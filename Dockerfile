FROM debian:buster

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

#WORKDIR /var/www/html
#VOLUME my_files

# installer nginx, php, mysql
RUN apt-get update && apt-get upgrade
RUN apt-get install -y nginx
RUN apt-get install -y mariadb-server
RUN apt-get install -y php7.3 php7.3-fpm php7.3-mysql

#copie des sources dans le container
COPY srcs /my_files

# configurer nginx
RUN rm /etc/nginx/sites-available/default
RUN mv /my_files/my_nginx_config /etc/nginx/sites-available/default
#RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# telecharger phpmyadmin et wordpress
RUN mv /my_files/wordpress /var/www/html/
RUN mv /my_files/phpmyadmin/ /var/www/html/

# importer la configuration de nginx (certificats, .conf etc)

# lancer un script lors du run
RUN mv /my_files/launch_script.sh /home/
RUN chmod 755 /home/launch_script.sh
#CMD service nginx start; service php7.3-fpm start; bash;
#CMD bash
CMD bash /home/launch_script.sh && bash

# faire le lien entre les ports (ou alors j'ai rien compris)
EXPOSE 80
#EXPOSE 443