FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt-get install php7.3 php-fpm php-mysql wget bash -y

RUN wget https://fr.wordpress.org/wordpress-6.7-fr_FR.tar.gz -P /var/www/html
RUN cd /var/www/html/ && tar -xzf wordpress-6.7-fr_FR.tar.gz && rm wordpress-6.7-fr_FR.tar.gz

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

#COPY conf/wp-config.php /var/www/html/wordpress
COPY conf/www.conf /etc/php/7.3/fpm/pool.d
COPY tools/auto_config.sh /

RUN mkdir /run/php

RUN chmod +x auto_config.sh

RUN chown -R www-data:www-data /run/php
RUN chown -R www-data:www-data /var/www/html/wordpress
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html

ENTRYPOINT ["/auto_config.sh"]

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.3", "-F"]
