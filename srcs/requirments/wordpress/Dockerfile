FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt-get install -y php7.3\
	php-fpm\
	php-mysql\
	mariadb-client\
	bash \
	curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php/7.4/fpm/pool.d

RUN mkdir /run/php

COPY tools/auto_start.sh /
RUN chmod +x auto_start.sh
ENTRYPOINT ["/auto_start.sh"]

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]
