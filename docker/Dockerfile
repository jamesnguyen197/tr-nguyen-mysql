FROM mysql:8.0

# 環境変数の設定
ENV MYSQL_DATABASE=metamoji_db1
ENV MYSQL_USER=metamoji
ENV MYSQL_PASSWORD=password
ENV MYSQL_ROOT_PASSWORD=password

# 初期データの追加
COPY ./init.sql /docker-entrypoint-initdb.d/