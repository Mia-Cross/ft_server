#!/bin/bash

# telecharger la derniere version de wordpress
wget -c  https://wordpress.org/latest.tar.gz -O - | tar -xz -C /var/www/localhost
chown -R www-data: /var/www/localhost/wordpress      

# telecharger la derniere version de phpmyadmin
wget -c https://files.phpmyadmin.net/phpMyAdmin/4.9.2/phpMyAdmin-4.9.2-english.tar.gz -O - | tar -xz -C /var/www/localhost
mv var/www/localhost/phpMyAdmin-4.9.2-english var/www/localhost/phpMyAdmin
chown -R www-data: /var/www/localhost/phpMyAdmin

# creer la cle et le certificat SSL
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj /C=FR/ST=IDF/L=Paris/O=42/CN=lemarabe/ \
    -keyout /etc/ssl/private/ssl_key.key -out /etc/ssl/certs/ssl_certif.crt

# demarrer les services dont on aura besoin
service nginx start
service php7.3-fpm start
service mysql start

# creer un utilisateur priviligié de la base de données
mysql -u root -e "CREATE DATABASE wordpress"
mysql -u root -e "GRANT ALL ON wordpress.* TO 'lemarabe'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION"
mysql -u root -e "FLUSH PRIVILEGES"

# redemarrer mysql pour appliquer les modifs de config
service mysql restart
