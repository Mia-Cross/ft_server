#!/bin/bash

echo "SCRIPT START"

# demarrer les services dont on aura besoin
service nginx start
service php7.3-fpm start
service mysql start

# creer un utilisateur priviligié de la base de données
mysql -u root -e "CREATE DATABASE wordpress"
mysql -u root -e "CREATE USER 'lemarabe'@'localhost' IDENTIFIED BY 'password'"
mysql -u root -e "GRANT ALL PRIVILEGES ON * . * TO 'lemarabe'@'localhost'"
mysql -u root -e "FLUSH PRIVILEGES"

# creer la cle et le certificat SSL
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj /C=FR/ST=IDF/L=Paris/O=42/CN=schene/ \
    -keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt

# redemarrer les services sur lesquels on a fait des modifs de config
service nginx restart
service mysql restart

echo "SCRIPT END"

#while [ TRUE ]; do
#	echo
#done
