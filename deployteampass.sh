#!/bin/bash
clear
apt update -y

# Descargar paquetes y configurar php.ini
apt-get install apache2 mariadb-server php7.4 php7.4-cli libapache2-mod-php7.4 php7.4-mysql php7.4-curl php7.4-mbstring php7.4-bcmath php7.4-common php7.4-gd php7.4-xml php7.4-ldap php-ldap git wget -y
sed -i "s/memory_limit = 128M/memory_limit = 256M/" /etc/php/7.4/apache2/php.ini
sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 100M/" /etc/php/7.4/apache2/php.ini
sed -i "s/max_execution_time = 30/max_execution_time = 360/" /etc/php/7.4/apache2/php.ini
sed -i "s#;date.timezone =#date.timezone = Europe/Madrid#g" /etc/php/7.4/apache2/php.ini

