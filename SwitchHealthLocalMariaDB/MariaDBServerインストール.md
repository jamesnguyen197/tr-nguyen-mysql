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
mysql --version
```
```
mysql  Ver 15.1 Distrib 10.5.10-MariaDB, for Linux (x86_64) using  EditLine wrapper
```

MariaDB 10.5.10 バージョンを確認できました。