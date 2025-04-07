#!/bin/bash
echo "Setting up database ${DB_NAME} and user ${DB_USER}..."

# INIT MYSQL #

service mariadb start;
sleep 0.5
mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"

# CREATING ADMIN USER #

mysql -e "SELECT 1 FROM mysql.user WHERE user='${DB_USER}' AND host='%' LIMIT 1;" | grep -q 1 || \
mysql -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"

# GRANT PERMISSIONS
mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES;"

# CREATING NORMAL USER #

#mysql -e "CREATE USER '${SQL_USER}'@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
#mysql -e "SELECT 1 FROM mysql.user WHERE user='${SQL_USER}' AND host='localhost';" | grep -q 1 || \
#mysql -e "CREATE USER '${SQL_USER}'@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

mysqladmin -p$DB_PASSWORD shutdown
exec mysqld_safe
