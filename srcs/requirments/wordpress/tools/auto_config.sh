#!/bin/bash

echo "WordPress, waiting for services to start..."
sleep 10

# Set the correct WordPress path
WP_PATH="/var/www/html/wordpress"

# Ensure the directory exists
mkdir -p $WP_PATH
cd $WP_PATH

echo "WordPress, checking if WordPress is installed...!"

# Download WordPress if not found
if [ ! -f "wp-load.php" ]; then
    echo "WordPress not found, downloading..."
    wp core download --allow-root --path=$WP_PATH
fi

# Ensure wp-cli is working
if ! wp --info > /dev/null 2>&1; then
    echo "WP-CLI is not installed correctly! Exiting..."
    exit 1
fi

# Check if wp-config.php exists
if [ -f "$WP_PATH/wp-config.php" ]; then
    echo "WordPress config file exists, updating database credentials..."
    sed -i "s/'DB_NAME', '.*'/'DB_NAME', '$DB_NAME'/" $WP_PATH/wp-config.php
    sed -i "s/'DB_USER', '.*'/'DB_USER', '$DB_USER'/" $WP_PATH/wp-config.php
    sed -i "s/'DB_PASSWORD', '.*'/'DB_PASSWORD', '$DB_PASSWORD'/" $WP_PATH/wp-config.php
    sed -i "s/'DB_HOST', '.*'/'DB_HOST', 'mariadb:3306'/" $WP_PATH/wp-config.php
else
    echo "Creating wp-config.php..."
    wp config create --allow-root \
        --dbname=$DB_NAME \
        --dbuser=$DB_USER \
        --dbpass=$DB_PASSWORD \
        --dbhost=mariadb:3306 --path=$WP_PATH
fi

# Install WordPress if not already installed
if ! wp core is-installed --allow-root --path=$WP_PATH; then
    echo "Installing WordPress..."
    wp core install --allow-root \
        --path=$WP_PATH \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER_NAME" \
        --admin_password="$WP_ADMIN_USER_PASSWORD" \
        --admin_email="$WP_ADMIN_USER_EMAIL"
else
    echo "WordPress is already installed!"
fi

# Create additional user (if needed)
if ! wp user get $WP_USER_NAME --allow-root --path=$WP_PATH > /dev/null 2>&1; then
    echo "Creating WordPress user: $WP_USER_NAME"
    wp user create $WP_USER_NAME $WP_USER_EMAIL --role=editor --user_pass=$WP_USER_PASSWORD --allow-root --path=$WP_PATH
else
    echo "User $WP_USER_NAME already exists!"
fi

echo "WordPress setup completed!"

exec "$@"
