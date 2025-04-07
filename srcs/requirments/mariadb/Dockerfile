FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt-get install mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d
COPY tools/init.sh /

RUN chmod +x init.sh

EXPOSE 3306

CMD ["sh", "/init.sh"]
