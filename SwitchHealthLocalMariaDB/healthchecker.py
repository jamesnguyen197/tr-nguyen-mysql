import socket
import sys

def is_mariadb_running_locally():
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        sock.connect(('localhost', 3306))
        # Connection successful, so MariaDB server is running
        sock.close()
        return True
    except socket.error:
        # Connection unsuccessful, so MariaDB server is not running
        sock.close()
        return False

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('Usage: python server.py <port>')
        sys.exit()

    port = int(sys.argv[1])
    debug = False
    if len(sys.argv) == 3 and sys.argv[2] == '--debug':
        debug = True

    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server_socket.bind(('0.0.0.0', port))
    server_socket.listen(3)

    if debug:
        print('Listening on port %d...' % port)

    while True:
        # Check if MariaDB server is running locally
        if is_mariadb_running_locally():
            # The MariaDB server is running, so set the NLB target group to healthy
            if debug:
                print('MariaDB server is running locally')
            server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)
        else:
            # The MariaDB server is not running, so set the NLB target group to unhealthy
            if debug:
                print('MariaDB server is not running locally')
            server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 0)

        # Accept new connections
        new_socket, address = server_socket.accept()
        # print('Connection accepted from %s:%d' % address)

        # Read message from the client
        buffer = new_socket.recv(1024)
        # print('Received message: %s' % buffer.decode())

        # Send message back to the client
        new_socket.send('Hello from server'.encode())
        # print('Hello message sent')

        new_socket.close()

    # Close the socket after the while loop
    server_socket.close()
