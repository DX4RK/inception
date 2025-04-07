FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt-get install nginx openssl -y

COPY conf/default /etc/nginx/sites-enabled

RUN openssl req -x509 -newkey rsa:2048 -nodes -keyout /etc/ssl/inception.key \
    -out /etc/ssl/inception.crt -days 365 \
    -subj "/C=FR/ST=Côte D'azur/L=Nice/O=42/CN=Inception"

EXPOSE 443

#CMD ["ls", "-a", "/etc/ssl/"]
CMD ["nginx", "-g", "daemon off;"]
