FROM debian:buster

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

# mise a jour des packages et installation de nginx, ssl, mysql et php 
RUN apt-get update && apt-get upgrade\
	&& apt-get install -y wget \
    && apt-get install -y nginx \
    && apt-get install -y openssl \
    && apt-get install -y mariadb-server \
    && apt-get install -y php7.3 php7.3-fpm php7.3-mysql

RUN mkdir /var/www/localhost && chown -R $USER:$USER /var/www/localhost

#copie des sources dans le container
COPY srcs /my_files

#configuration de nginx a partir des sources importees
RUN rm -f /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default \
    && mv /my_files/my_nginx_config /etc/nginx/sites-available/ \
	&& ln -s /etc/nginx/sites-available/my_nginx_config /etc/nginx/sites-enabled/ \
	&& chmod 755 /my_files/launch_script.sh

#executer le script de demarrage
CMD bash /my_files/launch_script.sh && bash

# faire le lien entre les ports de l'ordi et le reseau
EXPOSE 80 443
