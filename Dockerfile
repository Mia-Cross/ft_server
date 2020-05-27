FROM debian:buster

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

#WORKDIR /var/www/html
#VOLUME my_files

# installer nginx, php, mysql
RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y mariadb-server
RUN apt-get install -y php7.3 php7.3-fpm php7.3-mysql
COPY srcs /my_files

# configurer nginx
RUN rm /etc/nginx/sites-enabled/default
RUN mv /my_files/my_nginx_config /etc/nginx/sites-available/my_nginx_config
RUN ln -s /etc/nginx/sites-available/my_nginx_config /etc/nginx/sites-enabled/my_nginx_config

# telecharger phpmyadmin et wordpress
RUN mv /my_files/wordpress/* /var/www/html/
RUN mv /my_files/phpmyadmin/* /var/www/html/

# importer la configuration de nginx (certificats, .conf etc)

# lancer un script lors du run
EXPOSE 80
#EXPOSE 443
RUN chmod 755 /my_files/launch_script.sh
CMD service nginx start; service php7.3-fpm start; bash;
#CMD bash /my_files/launch_script.sh && bash
