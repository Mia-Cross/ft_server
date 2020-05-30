FROM debian:buster

LABEL maintainer="Leila Marabese lemarabe@student.42.fr"

#WORKDIR /var/www/html
#VOLUME my_files

# installer nginx, php, mysql

#copie des sources dans le container
COPY srcs /my_files

# configurer nginx

# telecharger phpmyadmin et wordpress
#RUN mv /my_files/wordpress /var/www/html/
#RUN mv /my_files/phpmyadmin /var/www/html/

# importer la configuration de nginx (certificats, .conf etc)

# lancer un script lors du run
#RUN mv /my_files/launch_script.sh /home/
RUN chmod 755 /my_files/launch_script.sh
#CMD service nginx start; service php7.3-fpm start; bash;
#CMD bash
#CMD bash /my_files/launch_script.sh && bash
CMD ["sh", "/my_files/launch_script.sh"]

# faire le lien entre les ports (ou alors j'ai rien compris)
EXPOSE 80
#EXPOSE 443