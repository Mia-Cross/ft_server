#!/bin/bash

# creer la cle et le certificat SSL
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/ssl_key.key -out /etc/ssl/certs/ssl_certif.crt

# demarrer les services dont on aura besoin
service nginx start
service php7.3-fpm start
service mysql start

# creer un utilisateur priviligié de la base de données
mysql -u root -e "CREATE DATABASE wordpress"
mysql -u root -e "CREATE USER 'lemarabe'@'localhost' IDENTIFIED BY 'password'"
mysql -u root -e "GRANT ALL PRIVILEGES ON * . * TO 'lemarabe'@'localhost'"
mysql -u root -e "FLUSH PRIVILEGES"

#supprimer la page d'accueil nginx pour qu'il affiche l'index a la place
rm -f /var/www/html/index.nginx-debian.html

# redemarrer les services sur lesquels on a fait des modifs de config
#service nginx restart
service mysql restart
