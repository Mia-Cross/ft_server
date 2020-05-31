FROM debian:buster

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

# installer nginx, php, mysql
RUN apt-get update && apt-get upgrade \
    && apt-get install -y nginx \
    && apt-get install -y openssl \
    && apt-get install -y mariadb-server \
    && apt-get install -y php7.3 php7.3-fpm php7.3-mysql

#copie des sources (wordpress et phpmyadmin) dans le container
COPY srcs /var/www/html/

#configurer nginx a partir des sources importees
RUN rm -f /etc/nginx/sites-available/default \
    && mv /var/www/html/my_nginx_config /etc/nginx/sites-available/default \
    && mv /var/www/html/launch_script.sh /home/ \
    && chmod 755 /home/launch_script.sh

#executer le script de demarrage
CMD bash /home/launch_script.sh && bash

# faire le lien entre les ports de l'ordi et le reseau
EXPOSE 80 443
