# checkの負荷を小さくする

local mariadb 稼働確認に health checker では system() function を利用しました。子プロセスを起動するので、linuxとしては重い処理です。そのとき、localhost:3306 ポートの接続確認で代替します。

localhost:3306 ポートの接続確認を行うことで、MariaDBがローカルで稼働しているかどうかを確認できます。これは、```is_mariadb_running_locally()``` 関数の中で ```socket()```、```connect()```、```close()``` 関数を利用し、MariaDBサーバーに接続を試すことが含まれます。```is_mariadb_running_locally()``` 関数内に以下のように変更します。
```
int is_mariadb_running_locally() {
    int sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock == -1) {
        perror("socket");
        exit(EXIT_FAILURE);
    }

    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK); // localhost
    addr.sin_port = htons(3306);

    int ret = connect(sock, (struct sockaddr*)&addr, sizeof(addr));
    if (ret == 0) {
        // Connection successful, so MariaDB server is running
        close(sock);
        return 1;
    } else {
        // Connection unsuccessful, so MariaDB server is not running
        close(sock);
        return 0;
    }
}
```

指定されたポート番号（3306）を利用してして、MariaDB Server が local で実行されているかどうかを確認します。ソケットを作成して成功するまで各々のIPアドレスに接続を試すか、すべてのアドレスが試されるまで続けて、localhostに接続を試みます。

接続が成功した場合は1を、失敗した場合は0を返します。成功した場合はソケットを閉じて1を返して、失敗した場合はソケットを閉じて0を返します。

次にプログラムを実行してみます。
```
gcc -o healthchecker ListenPortMariaDB.c
./healthchecker 13306 --debug &
```
MariaDB を止まっている状態です。
```
[ec2-user@ip-10-0-147-166 ~]$ ./healthchecker 13306 --debug
Listening on port 13306...
MariaDB server is not running locally
setsockopt: Invalid argument
```

MariaDB を起動してみると以下の結果になります。
```
[ec2-user@ip-10-0-147-166 ~]$ Listening on port 13306...
MariaDB server is running locally
MariaDB server is running locally
```

ポートの確認は以下のコマンドを入力します。
```
[ec2-user@ip-10-0-147-166 ~]$ sudo lsof -i -P -n | grep LISTEN
rpcbind   2646      rpc    8u  IPv4  16227      0t0  TCP *:111 (LISTEN)
rpcbind   2646      rpc   11u  IPv6  16230      0t0  TCP *:111 (LISTEN)
master    3116     root   13u  IPv4  17966      0t0  TCP 127.0.0.1:25 (LISTEN)
sshd      3200     root    3u  IPv4  19134      0t0  TCP *:22 (LISTEN)
sshd      3200     root    4u  IPv6  19136      0t0  TCP *:22 (LISTEN)
mariadbd  6728    mysql   28u  IPv6  37518      0t0  TCP *:3306 (LISTEN)
healthche 6816 ec2-user    3u  IPv4  37660      0t0  TCP *:13306 (LISTEN)
```

現在、Mariadb は 3306 ポートで働いています。healthchecker は 13306 ポートで働いています。つまり、localhost:3306 ポートの接続確認ができました。