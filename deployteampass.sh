#!/bin/bash
#set -x
set -e

clear
echo "Se van a actualizar los paquetes y repositorios del sistema"
sleep 3s
clear
apt update -y
clear
echo "Paquetes y repositorios actualizados"
sleep 4s

# Declarar contraseñas para el usuario root y el usuario de la base de datos Teampass en servidor mysql
read -p "Contraseña para el usuario root en mysql server: " DB_ROOTPW
read -p "Nombre de usuario de la base de datos de Teampass en mysql server: " DB_USERNM
read -p "Contraseña para el usuario $DB_USERNM en mysql server: " DB_USERPW
clear

# Descargar paquetes y configurar php.ini
echo "Se van a instalar los paquetes necesarios para el despliegue de la aplicacion"
apt-get install apache2 mariadb-server php7.4 php7.4-cli libapache2-mod-php7.4 php7.4-mysql php7.4-curl php7.4-mbstring php7.4-bcmath php7.4-common php7.4-gd php7.4-xml php7.4-ldap php-ldap git wget unzip -y
sed -i "s/memory_limit = 128M/memory_limit = 256M/" /etc/php/7.4/apache2/php.ini
sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 100M/" /etc/php/7.4/apache2/php.ini
sed -i "s/max_execution_time = 30/max_execution_time = 360/" /etc/php/7.4/apache2/php.ini
sed -i "s#;date.timezone =#date.timezone = Europe/Madrid#g" /etc/php/7.4/apache2/php.ini

# Añadir contraseña al usuario root para mejor seguridad
mysql -u root <<< "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOTPW';"

# Crear base de datos
mysql -u root -p$DB_ROOTPW <<< "create database teampass;"
mysql -u root -p$DB_ROOTPW <<< "grant all privileges on teampass.* to $DB_USERNM@localhost identified by '$DB_USERPW';"
mysql -u root -p$DB_ROOTPW <<< "FLUSH PRIVILEGES;"

# Movernos al directorio /var/www/html, descargar Teampas 2.1.27.36 y realizar configuraciones
cd /var/www/html
wget https://github.com/nilsteampassnet/TeamPass/archive/refs/tags/2.1.27.36.zip
exit
unzip "2.1.27.36.zip"
mv "TeamPass-2.1.27.36" teampass
rm "2.1.27.36.zip"
chown -R www-data.www-data /var/www/html/teampass/
chmod -R 775 /var/www/html/teampass/
