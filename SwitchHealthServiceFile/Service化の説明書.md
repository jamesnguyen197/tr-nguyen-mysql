# ListenPortMariaDBの Service化

商用サービスの運用で使うhealth checker には下記の要件もあります。
* なにかの原因でprocessがkillされてもすぐに再起動して health checkの機能を停めません。
* Instance の restart や reboot が上記の原因でも、自動起動しなければなりません。

ListenPortMariaDB.c をサービス化するには、以下の手順に従うことができます。
1. ListenPortMariaDB.c をコンパイルして実行可能ファイルを作成します。
    ```
    gcc -o healthchecker ListenPortMariaDB.c
    ```
    **※** healthchecker は ```/usr/local/bin/``` までコピーします
    。
    ```
    sudo cp ./healthchecker /usr/local/bin/.
    ```

2. ```/etc/systemd/system/``` ディレクトリに ListenPortMariaDB.service という名前の新しいサービスファイルを作成します。**[サービスファイル](./healthchecker.service)** の内容は以下のようになります。
    ```
    [Unit]
    Description=healthchecker
    After=mariadb.service network.target

    [Service]
    Type=simple
    ExecStart=/usr/local/bin/healthchecker 13306
    Restart=always

    [Install]
    WantedBy=multi-user.target
    ```

* After=mariadb.service network.target は、ListenPortMariaDB が実行される前に、MariaDB とネットワークが起動していることを保証します。

* Type=simple は、healthchecker がバックグラウンドで実行される簡単なサービスであることを指定します。

* ExecStart=/home/ec2-user/healthchecker 13306 は、ポート 13306 で healthchecker を実行するコマンドを指定します。

* Restart=always は、healthchecker が processが killされても自動的に再起動するように設定します。

3. サービスファイルを再読み込みして、mariadbと healthchecker を自動起動するように設定します。

    ```
    sudo systemctl daemon-reload
    sudo systemctl enable mariadb healthchecker
    ```

    ```sudo systemctl status mariadb healthchecker``` を入力すると、mariadb と healthchecker を起動していないとき、以下のメッセージが出ます。
    ```
    [ec2-user@ip-10-0-147-166 ~]$ sudo systemctl status mariadb healthchecker
    ● mariadb.service - MariaDB 10.5 database server
    Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; vendor pres                                                                                                 et: disabled)
    Active: inactive (dead) since Thu 2023-03-09 06:34:41 UTC; 17s ago
        Docs: man:mariadbd(8)
            https://mariadb.com/kb/en/library/systemd/
    Process: 3057 ExecStart=/usr/libexec/mariadbd --basedir=/usr $MYSQLD_OPTS $_WS                                                                                                 REP_NEW_CLUSTER (code=exited, status=0/SUCCESS)
    Main PID: 3057 (code=exited, status=0/SUCCESS)
    Status: "MariaDB server is down"

    Mar 09 05:30:28 ip-10-0-147-166.ec2.internal systemd[1]: Starting MariaDB 10....
    Mar 09 05:30:29 ip-10-0-147-166.ec2.internal mariadb-prepare-db-dir[2999]: Da...
    Mar 09 05:30:30 ip-10-0-147-166.ec2.internal mariadbd[3057]: 2023-03-09  5:30...
    Mar 09 05:30:30 ip-10-0-147-166.ec2.internal systemd[1]: Started MariaDB 10.5...
    Mar 09 06:34:41 ip-10-0-147-166.ec2.internal systemd[1]: Stopping MariaDB 10....
    Mar 09 06:34:41 ip-10-0-147-166.ec2.internal systemd[1]: Stopped MariaDB 10.5...

    ● healthchecker.service - healthchecker
    Loaded: loaded (/etc/systemd/system/healthchecker.service; enabled; vendor preset: disabled)
   Active: inactive (dead)
    Hint: Some lines were ellipsized, use -l to show in full.
    [ec2-user@ip-10-0-147-166 ~]$ sudo systemctl status mariadb healthchecker
    ● mariadb.service - MariaDB 10.5 database server
    Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; vendor preset: disabled)
    Active: inactive (dead) since Thu 2023-03-09 06:34:41 UTC; 20s ago
        Docs: man:mariadbd(8)
            https://mariadb.com/kb/en/library/systemd/
    Process: 3057 ExecStart=/usr/libexec/mariadbd --basedir=/usr $MYSQLD_OPTS $_WSREP_NEW_CLUSTER (code=exited, status=0/SUCCESS)
    Main PID: 3057 (code=exited, status=0/SUCCESS)
    Status: "MariaDB server is down"

    Mar 09 05:30:28 ip-10-0-147-166.ec2.internal systemd[1]: Starting MariaDB 10.5 database server...
    Mar 09 05:30:29 ip-10-0-147-166.ec2.internal mariadb-prepare-db-dir[2999]: Database MariaDB is probably initialized in /var/lib/mysql already, nothing is done.
    Mar 09 05:30:30 ip-10-0-147-166.ec2.internal mariadbd[3057]: 2023-03-09  5:30:30 0 [Note] /usr/libexec/mariadbd (mysqld 10.5.10-MariaDB) starting as process 3057 ...
    Mar 09 05:30:30 ip-10-0-147-166.ec2.internal systemd[1]: Started MariaDB 10.5 database server.
    Mar 09 06:34:41 ip-10-0-147-166.ec2.internal systemd[1]: Stopping MariaDB 10.5 database server...
    Mar 09 06:34:41 ip-10-0-147-166.ec2.internal systemd[1]: Stopped MariaDB 10.5 database server.

    ● healthchecker.service - healthchecker
    Loaded: loaded (/etc/systemd/system/healthchecker.service; enabled; vendor preset: disabled)
    Active: inactive (dead)

    ```

    このため、mariadbと ListenPortMariaDBを自動起動するように設定します。
    ```
    sudo systemctl start mariadb ListenPortMariaDB
    ```

これで、ListenPortMariaDBは自動的に起動し、ProcessがKillされても自動的に再起動されます。また、MariaDBが起動するたびに ListenPortMariaDBも起動するように設定されます。

nguyen-1 で ListenPortMariaDBを service化したので、nguyen-1 の Instanceを再起動しても Target Groupで nguyen-1 は Healthyの状態です。
<div style="text-align: center;">
<img src="./nguyen-1Healthy.png" width="100%"/></div>