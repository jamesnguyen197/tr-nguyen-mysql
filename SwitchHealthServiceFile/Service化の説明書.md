# ListenPortMariaDBの Service化

商用サービスの運用で使うhealth checker には下記の要件もあります。
* なにかの原因でprocessがkillされてもすぐに再起動して health checkの機能を停めません。
* Instance の restart や reboot が上記の原因でも、自動起動しなければなりません。

ListenPortMariaDB.c をサービス化するには、以下の手順に従うことができます。
1. ListenPortMariaDB.c をコンパイルして実行可能ファイルを作成します。
    ```
    gcc -o ListenPortMariaDB ListenPortMariaDB.c
    ```
    **※** ListenPortMariaDB は ```/home/ec2-user``` でコンパイルします。

2. ```/etc/systemd/system/``` ディレクトリに ListenPortMariaDB.service という名前の新しいサービスファイルを作成します。**[サービスファイル](./ListenPortMariaDB.service)** の内容は以下のようになります。
    ```
    [Unit]
    Description=ListenPortMariaDB
    After=mariadb.service network.target

    [Service]
    Type=simple
    ExecStart=/home/ec2-user/ListenPortMariaDB 13306
    Restart=always

    [Install]
    WantedBy=multi-user.target
    ```

* After=mariadb.service network.target は、ListenPortMariaDB が実行される前に、MariaDB とネットワークが起動していることを保証します。

* Type=simple は、ListenPortMariaDB がバックグラウンドで実行される簡単なサービスであることを指定します。

* ExecStart=/home/ec2-user/ListenPortMariaDB 13306 は、ポート 13306 で ListenPortMariaDB を実行するコマンドを指定します。

* Restart=always は、ListenPortMariaDB が processが killされても自動的に再起動するように設定します。

3. サービスファイルを再読み込みして、mariadbと ListenPortMariaDB を自動起動するように設定します。

    ```
    sudo systemctl daemon-reload
    sudo systemctl enable mariadb ListenPortMariaDB
    ```

    ```sudo systemctl status ListenPortMariaDB```ListenPortMariaDB を起動していないとき、以下のメッセージが出ます。
    ```
    [ec2-user@ip-10-0-147-166 ~]$ sudo systemctl status ListenPortMariaDB
    ● ListenPortMariaDB.service - ListenPortMariaDB
    Loaded: loaded (/etc/systemd/system/ListenPortMariaDB.service; enabled; vendor preset: disabled)
    Active: failed (Result: start-limit) since Thu 2023-03-09 00:26:22 UTC; 6s ago
    Process: 3427 ExecStart=/home/ec2-user/ListenPortMariaDB 13306 (code=exited, status=1/FAILURE)
    Main PID: 3427 (code=exited, status=1/FAILURE)

    Mar 09 00:26:22 ip-10-0-147-166.ec2.internal systemd[1]: ListenPortMariaDB.service: main process exited, code=exit...LURE
    Mar 09 00:26:22 ip-10-0-147-166.ec2.internal systemd[1]: Unit ListenPortMariaDB.service entered failed state.
    Mar 09 00:26:22 ip-10-0-147-166.ec2.internal systemd[1]: ListenPortMariaDB.service failed.
    Mar 09 00:26:22 ip-10-0-147-166.ec2.internal systemd[1]: ListenPortMariaDB.service holdoff time over, scheduling restart.
    Mar 09 00:26:22 ip-10-0-147-166.ec2.internal systemd[1]: Stopped ListenPortMariaDB.
    Mar 09 00:26:22 ip-10-0-147-166.ec2.internal systemd[1]: start request repeated too quickly for ListenPortMariaDB.service
    Mar 09 00:26:22 ip-10-0-147-166.ec2.internal systemd[1]: Failed to start ListenPortMariaDB.
    Mar 09 00:26:22 ip-10-0-147-166.ec2.internal systemd[1]: Unit ListenPortMariaDB.service entered failed state.
    Mar 09 00:26:22 ip-10-0-147-166.ec2.internal systemd[1]: ListenPortMariaDB.service failed.
    Hint: Some lines were ellipsized, use -l to show in full.
    ```

    このため、mariadbと ListenPortMariaDBを自動起動するように設定します。
    ```
    sudo systemctl start mariadb ListenPortMariaDB
    ```

これで、ListenPortMariaDBは自動的に起動し、ProcessがKillされても自動的に再起動されます。また、MariaDBが起動するたびに ListenPortMariaDBも起動するように設定されます。