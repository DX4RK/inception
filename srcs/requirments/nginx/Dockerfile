FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt-get install nginx -y
RUN apt install openssl -y

COPY conf/server.conf /etc/nginx/conf.d/
COPY conf/nginx.conf /etc/nginx/

COPY conf/certificates/default.crt /etc/ssl/certs/
COPY conf/certificates/default.key /etc/ssl/private/

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

CMD [ "nginx", "-g", "daemon off;" ]
