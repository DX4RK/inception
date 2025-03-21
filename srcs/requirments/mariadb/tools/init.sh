#!/bin/bash
echo "Setting up database ${SQL_DATABASE} and user ${SQL_USER}..."

# INIT MYSQL #

service mariadb start;
sleep 0.5
mysql -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};"

# CREATING ADMIN USER #

mysql -e "CREATE USER '${SQL_ROOT_USER}'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${SQL_ROOT_USER}'@'localhost' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES;"

# CREATING NORMAL USER #

mysql -e "CREATE USER '${SQL_USER}'@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

mysqladmin -p$SQL_ROOT_PASSWORD shutdown
exec mysqld_safe
