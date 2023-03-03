#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <errno.h>

int is_mariadb_running_locally() {
    // Use system() function to execute the "systemctl status mariadb" command
    int ret = system("systemctl status mariadb > /dev/null");
    if (ret == 0) {
        // The MariaDB server is running
        return 1;
    } else {
        // The MariaDB server is not running
        return 0;
    }
}

int main(int argc, char *argv[]) {    
    int port = atoi(argv[1]);
    int server_socket, new_socket, valread;
    struct sockaddr_in address;
    int opt = 1;
    int addrlen = sizeof(address);
    char buffer[1024] = {0};
    char *hello = "Hello from server";
       
    // Create socket file descriptor
    if ((server_socket = socket(AF_INET, SOCK_STREAM, 0)) == 0) {
        perror("socket failed");
        exit(EXIT_FAILURE);
    }
       
    // Set socket options
    if (setsockopt(server_socket, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT, &opt, sizeof(opt))) {
        perror("setsockopt");
        exit(EXIT_FAILURE);
    }
    address.sin_family = AF_INET;
    address.sin_addr.s_addr = INADDR_ANY;
    address.sin_port = htons(port);
       
    // Bind the socket to the given port
    if (bind(server_socket, (struct sockaddr *)&address, sizeof(address))<0) {
        perror("bind failed");
        exit(EXIT_FAILURE);
    }
    // Start listening on the socket
    if (listen(server_socket, 3) < 0) {
        perror("listen");
        exit(EXIT_FAILURE);
    }
    printf("Listening on port %d...\n", port);
    
    while(1) {
        // Check if MariaDB server is running locally
        if (is_mariadb_running_locally()) {
            // The MariaDB server is running, so set the NLB target group to healthy
            printf("MariaDB server is running locally\n");
            if (setsockopt(server_socket, SOL_SOCKET, SO_KEEPALIVE, &opt, sizeof(opt)) < 0) {
                perror("setsockopt");
                exit(EXIT_FAILURE);
            }
        } else {
            // The MariaDB server is not running, so set the NLB target group to unhealthy
            printf("MariaDB server is not running locally\n");
            if (setsockopt(server_socket, SOL_SOCKET, SO_KEEPALIVE, NULL, 0) < 0) {
                perror("setsockopt");
                exit(EXIT_FAILURE);
            }
        }

        // Accept new connections
        if ((new_socket = accept(server_socket, (struct sockaddr *)&address, (socklen_t*)&addrlen))<0) {
            perror("accept");
            exit(EXIT_FAILURE);
        }
        printf("Connection accepted from %s:%d\n", inet_ntoa(address.sin_addr), ntohs(address.sin_port));
        
        // Read message from the client
        valread = read( new_socket , buffer, 1024);
        printf("Received message: %s\n",buffer );
        
        // Send message back to the client
        send(new_socket , hello , strlen(hello) , 0 );
        printf("Hello message sent\n");
        close(new_socket);
    }
    return 0;
}
