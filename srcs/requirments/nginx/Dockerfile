FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt-get install nginx openssl -y

COPY conf/default /etc/nginx/sites-enabled

COPY certificates/inception.crt /etc/ssl/
COPY certificates/inception.key /etc/ssl/

EXPOSE 443

#CMD ["ls", "-a", "/etc/ssl/"]
CMD ["nginx", "-g", "daemon off;"]
