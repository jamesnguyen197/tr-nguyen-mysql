# MariaDB Serverをインストール方法

普段以下のコマンド
```
sudo yum install mariadb-server
```
をインストールすると、MariaDB 10.5.* 以上が入っています。

MariaDB 10.5.* を採用する理由は ```amazon-linux-extras``` からインストールできるのが 10.5.* です。
```
[ec2-user@mps501-test-mrg-1 ~]$ amazon-linux-extras | grep maria
 54  mariadb10.5              available    [ =stable ]
```
extras に入っていると他社での利用実績も多くなり、インターネット上に情報も多いので、困ったことが起きたとき、なんとか対応できると思います。

MariaDB 10.5.* をインストールするために、以下のコマンドを入力します。
```
sudo amazon-linux-extras enable mariadb10.5
sudo yum clean metadata
sudo yum install mariadb
```

インストールできましたら、バージョンを確認します。
```
mariadb --version
```
```
mariadb  Ver 15.1 Distrib 10.5.10-MariaDB, for Linux (x86_64) using  EditLine wrapper
```
次に以下を入力します。
```
yum list installed | grep -i mariadb
```
以下にバージョンが表示されます。
```
Judy.x86_64                    1.0.5-8.amzn2.0.1         @amzn2extra-mariadb10.5
libsphinxclient.x86_64         2.2.11-5.amzn2.0.1        @amzn2extra-mariadb10.5
mariadb.x86_64                 3:10.5.10-2.amzn2.0.2     @amzn2extra-mariadb10.5
mariadb-backup.x86_64          3:10.5.10-2.amzn2.0.2     @amzn2extra-mariadb10.5
mariadb-common.x86_64          3:10.5.10-2.amzn2.0.2     @amzn2extra-mariadb10.5
mariadb-config.x86_64          3:10.5.10-2.amzn2.0.2     @amzn2extra-mariadb10.5
mariadb-connect-engine.x86_64  3:10.5.10-2.amzn2.0.2     @amzn2extra-mariadb10.5
mariadb-cracklib-password-check.x86_64
                               3:10.5.10-2.amzn2.0.2     @amzn2extra-mariadb10.5
mariadb-devel.x86_64           3:10.5.10-2.amzn2.0.2     @amzn2extra-mariadb10.5
mariadb-errmsg.x86_64          3:10.5.10-2.amzn2.0.2     @amzn2extra-mariadb10.5
mariadb-gssapi-server.x86_64   3:10.5.10-2.amzn2.0.2     @amzn2extra-mariadb10.5
mariadb-libs.x86_64            3:10.5.10-2.amzn2.0.2     @amzn2extra-mariadb10.5
mariadb-oqgraph-engine.x86_64  3:10.5.10-2.amzn2.0.2     @amzn2extra-mariadb10.5
mariadb-pam.x86_64             3:10.5.10-2.amzn2.0.2     @amzn2extra-mariadb10.5
mariadb-rocksdb-engine.x86_64  3:10.5.10-2.amzn2.0.2     @amzn2extra-mariadb10.5
mariadb-server.x86_64          3:10.5.10-2.amzn2.0.2     @amzn2extra-mariadb10.5
mariadb-server-utils.x86_64    3:10.5.10-2.amzn2.0.2     @amzn2extra-mariadb10.5
mariadb-sphinx-engine.x86_64   3:10.5.10-2.amzn2.0.2     @amzn2extra-mariadb10.5
mytop.noarch                   1.7-20.b737f60.amzn2      @amzn2extra-mariadb10.5
sphinx.x86_64                  2.2.11-5.amzn2.0.1        @amzn2extra-mariadb10.5
```
その中に、MadiaDB Server が存在します。MariaDB 10.5.10 バージョンを確認できました。

MariaDB を起動してlocal の mariadb-server に接続します。

※ すべて権限を渡すことは必要なので、root権限で操作します。

1. MariaDB を起動します。
    ```
    sudo systemctl start mariadb
    ```
    MariaDB の起動は、systemctl コマンドの起動を使用して行います。sudo コマンドを利用して root 権限で実行します。
    ```
    sudo systemctl status mariadb
    ```
    以上のコマンドを入力すると、確認できます。```active``` または ```inactive``` の状態で確認します。

2. mysql コマンドラインクライアントにアクセスして、local の mariadb-server に接続します。
    ```
    sudo mysql -h localhost -P 13306
    ```
    * ホスト名: ```-h localhost``` または ```--host=localhost``` 
    * ポート番号: ```-P 13306``` または ```--port=13306```

    以下の画面が出ています。

    ```
    Welcome to the MariaDB monitor.  Commands end with ; or \g.
    Your MariaDB connection id is 10
    Server version: 10.5.10-MariaDB MariaDB Server

    Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

    MariaDB [(none)]>
    ```
3. mariadb-server のバージョンを SELECT 文で表示するとき、以下を
    ```
    SELECT VERSION();
    ```
    入力すると、MariaDBのバージョンを確認できます。
    ```
    +-----------------+
    | VERSION()       |
    +-----------------+
    | 10.5.10-MariaDB |
    +-----------------+
    1 row in set (0.000 sec)
    ```