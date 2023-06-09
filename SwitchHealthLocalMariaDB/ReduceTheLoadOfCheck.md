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

また、**[Health Checkerの Service化](https://github.com/metamoji/tr-nguyen-mysql/blob/main/SwitchHealthServiceFile/Service%E5%8C%96%E3%81%AE%E8%AA%AC%E6%98%8E%E6%9B%B8.md)** により、以上のプログラムをサービス化してみます。

```
[ec2-user@ip-10-0-147-166 ~]$ sudo systemctl status mariadb healthchecker
● mariadb.service - MariaDB 10.5 database server
   Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; vendor preset: disabled)
   Active: active (running) since Thu 2023-03-09 08:32:31 UTC; 9min ago
     Docs: man:mariadbd(8)
           https://mariadb.com/kb/en/library/systemd/
 Main PID: 6728 (mariadbd)
   Status: "Taking your SQL requests now..."
   CGroup: /system.slice/mariadb.service
           └─6728 /usr/libexec/mariadbd --basedir=/usr

Mar 09 08:32:31 ip-10-0-147-166.ec2.internal systemd[1]: Starting MariaDB 10.5 database server...
Mar 09 08:32:31 ip-10-0-147-166.ec2.internal mariadb-prepare-db-dir[6689]: Database MariaDB is probably initialized in /var/lib/mysql already, nothing is done.
Mar 09 08:32:31 ip-10-0-147-166.ec2.internal mariadbd[6728]: 2023-03-09  8:32:31 0 [Note] /usr/libexec/mariadbd (mysqld 10.5.10-MariaDB) starting as process 6728 ...
Mar 09 08:32:31 ip-10-0-147-166.ec2.internal systemd[1]: Started MariaDB 10.5 database server.

● healthchecker.service - healthchecker
   Loaded: loaded (/etc/systemd/system/healthchecker.service; enabled; vendor preset: disabled)
   Active: active (running) since Thu 2023-03-09 08:38:09 UTC; 4min 18s ago
 Main PID: 6939 (healthchecker)
   CGroup: /system.slice/healthchecker.service
           └─6939 /opt/metamoji/bin/healthchecker 13306

Mar 09 08:38:09 ip-10-0-147-166.ec2.internal systemd[1]: Started healthchecker.
```
実行している状態です。また、Target Groupで確認するとき、instance nguyen-1 が Healthyになります。

<div style="text-align: center;">
<img src="./Image/auto-nguyen-1-healthy.png" width="100%"/></div>
