FROM debian:buster

#install what we need and erase file that we don't need
RUN apt-get update && apt-get upgrade && apt-get install wget nginx openssl php7.3-fpm php7.3-mysql mariadb-server -y \
&& rm -f /etc/nginx/sites-available/default /var/www/html/index.nginx-debian.html

#copy of the sources
COPY srcs /var/www/html/
RUN mv /var/www/html/my_nginx_config /etc/nginx/sites-available/ \
&& mv /var/www/html/launch_script.sh /home/ && chmod u+x /home/launch_script.sh

#execute script
CMD bash /home/launch_script.sh && bash

EXPOSE 8080 80 443
