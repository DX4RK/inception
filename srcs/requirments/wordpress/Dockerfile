FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt-get install wget -y
RUN apt-get install nginx -y

RUN apt-get install -y php7.3\
 php-fpm\
 php-mysql\
 mariadb-client

RUN wget https://fr.wordpress.org/wordpress-6.7-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.7-fr_FR.tar.gz && rm wordpress-6.7-fr_FR.tar.gz

RUN chown -R www-data:www-data /var/www/html

COPY conf/wp-config.php /var/www/wordpress
