FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt-get -y install \
	php7.4 \
	php-fpm \
	php-mysql \
	php-cgi \
	php-pdo \
	php-gd php-cli \
	php-mbstring \
	redis \
	php-redis \
	wget \
	curl \
	bash

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php/7.4/fpm/pool.d

RUN mkdir /run/php

WORKDIR /var/www/html/

COPY tools/auto_start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/auto_start.sh
ENTRYPOINT ["/usr/local/bin/auto_start.sh"]

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]
