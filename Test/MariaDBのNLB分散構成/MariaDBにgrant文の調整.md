# MariaDBにGrant文の調整
MariaDB は、オープンソースで完全に互換性のあるリレーショナル データベース管理システム (RDBMS) です。 MariaDB クライアントを使用すると、新しいユーザーを簡単に追加して様々なレベルの権限を付与できます。

## **状況**

以下のコマンド
```
[ec2-user@ip-10-0-147-166 ~]$ mysql -u root -h 10.0.157.33 -P 3306
```
を入力すると、以下のエラーが発生しています。

```
ERROR 1130 (HY000): Host 'ip-10-0-147-166.ec2.internal' is not allowed to connect to this MariaDB server
```

権限を渡していない状況です。つまり、Grant文を調整していないと、アクセスできません。

## **MariaDB サーバーへのアクセス**

次のコマンドを入力して MariaDB クライアントにアクセスします。
```
sudo mysql -u root
```
## **MariaDB の新ユーザーの作成**
MariaDB の新ユーザーを作成するには、次のコマンドを入力します。
```
CREATE USER 'metamoji'@localhost IDENTIFIED BY 'password';
```

* 新ユーザー: metamoji
* パスワード: password

次に metamoji ユーザーが作成できたのかを確認します。
```
SELECT user,host FROM mysql.user;
```
```
mysql> SELECT user,host FROM mysql.user;
+-------------+------------------------------+
| User        | Host                         |
+-------------+------------------------------+
| metamoji    | localhost                    |
| mariadb.sys | localhost                    |
| mysql       | localhost                    |
| root        | localhost                    |
+-------------+------------------------------+
6 rows in set (0.00 sec)
```

## **MariaDB ユーザーに権限を渡す**
作成された新ユーザーには、データベースを管理する権限も MariaDB にアクセスする権限もありません。そのとき、すべての権限を metamoji に渡します。
```
GRANT ALL PRIVILEGES ON *.* TO 'metamoji'@'%' IDENTIFIED BY 'password';
```

現在、```nguyen-1``` でDBにアクセスします。```nguyen-1``` と ```nguyen-2``` と ```kawanoy-1``` から各DBにアクセスしたい場合、すべてのIPアドレスにアクセス権限が必要です。

```
SHOW GRANTS FOR 'metamoji'@'ip-10-0-11-33.ec2.internal';
```
```
+----------------------------------------------------+
Grants for metamoji@ip-10-0-11-33.ec2.internal                       
+----------------------------------------------------+

GRANT ALL PRIVILEGESON *.* TO `metamoji`@`ip-10-0-11-33.ec2.internal` IDENTIFIED BY PASSWORD '************' 
+----------------------------------------------------+

1 row in set (0.00 sec)
```

```10.0.11.33``` からDBにアクセスできると表示されています。

新権限が付与されたら、権限をリロードすることは必要です。
```
FLUSH PRIVILEGES;
```

```nguyen-2``` も同じ手順で行います。ここで省略します。

```nguyen-1``` から ```nguyen-2``` のDBにアクセスしてみると、
```
mysql -u metamoji -h 10.0.157.33 -P 3306
```
ユーザー (metamoji) とパスワード (password)を入力したら、以下の結果になります。
```
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 270
Server version: 5.5.5-10.5.18-MariaDB MariaDB Server

Copyright (c) 2000, 2023, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
```

```nguyen-1``` から ```nguyen-2``` にアクセスできます。逆に ```nguyen-2``` から ```nguyen-1``` にもアクセスできます。