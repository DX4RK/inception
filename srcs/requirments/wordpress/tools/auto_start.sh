#!/bin/sh

echo "WordPress, waiting for services to start..."
sleep 10

echo "WordPress, installing..."

wp core download --path=/var/www/html --allow-root

wp config create	--allow-root \
	--dbname=$DB_NAME \
	--dbuser=$DB_USER \
	--dbpass=$DB_PASSWORD \
	--dbhost=mariadb:3306 \
	--path='/var/www/html'

wp core install --allow-root \
	--url="$DOMAIN_NAME" \
	--title="Inception" \
	--admin_user="$WP_ADMIN_USER_NAME" \
	--admin_password="$WP_ADMIN_USER_PASSWORD" \
	--admin_email="$WP_ADMIN_USER_EMAIL" \
	--path='/var/www/html'

echo "WordPress setup completed!"

exec "$@"
