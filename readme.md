# Despliegue de Teampass versión 2.1.27.36

## Requisitos mínimos previos
- **Sistema operativo**: Preferiblemente Ubuntu server por tener mayor soporte, aunque también se puede trabajar con otras distribuciones GNU/Linux.
- **Dirección IP de máquina estática/fija.**
- **Pila LAMP (Linux, Apache, MySQL y PHP).**

## Configuración y despliegue
Se puede hacer uso del script incluido llamado deployteampass.sh para la configuración previa del servidor y el despliegue de la palicación, igualmente, se explicarán los pasos a seguir:

1. Descargar paquetes necesarios para el servidor (automatizado en el script)

>apt-get install apache2 mariadb-server php7.4 php7.4-cli libapache2-mod-php7.4 php7.4-mysql php7.4-curl php7.4-mbstring php7.4-bcmath php7.4-common php7.4-gd php7.4-xml php7.4-ldap php-ldap git wget unzip -y

2. Configurar archivo php.ini (automatizado en el script)

>nano /etc/php/7.4/apache2/php.ini

Buscar los siguientes parámetros y cambiarlos por los valores indicados:

>memory_limit = por memory_limit = 256M

>upload_max_filesize = por upload_max_filesize = 100M

>max_execution_time = por max_execution_time = 360

>;date.timezone = por date.timezone = Europe/Madrid

3. Crear base de datos (automatizado en el script)

>mysql -u root

>ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOTPW';

>CREATE DATABASE teampass;

>GRANT ALL PRIVILEGES ON teampass.* TO teampass@localhost IDENTIFIED BY "ContraseñaDelUsuarioTeampass";

>exit;

4. Movernos al directorio /var/www/html, descargar Teampass 2.1.27.36, extraerlo y cambiar nombre (automatizado en el sript)

>cd /var/www/html

>wget https://github.com/nilsteampassnet/TeamPass/archive/refs/tags/2.1.27.36.zip

>unzip 2.1.27.36.zip

>mv "TeamPass-2.1.27.36" teampass

Se puede eliminar el .zip descargado ya que no lo vamos a utilizar más

5. Aplicar los permisos y usuario necesarios

>chown -R www-data.www-data /var/www/html/teampass/

>chmod -R 775 /var/www/html/teampass/

**Nota, a partir de aquí los pasos dejan de estar automatizados en el script**

6. Crear fichero de configuración para el servidor apache

>nano /etc/apache2/sites-available/teampass.conf

    <VirtualHost *:80>
         ServerAdmin admin@example.com
         DocumentRoot /var/www/html/TeamPass   
         ServerName teampass.linuxbuz.com

         <Directory /var/www/html/TeamPass>    
              Options FollowSymlinks
              AllowOverride All
              Require all granted
         </Directory>  

         ErrorLog ${APACHE_LOG_DIR}/teampass_error.log
         CustomLog ${APACHE_LOG_DIR}/teampass_access.log combined

    </VirtualHost>

# TeampassImportConverter

Fixes format errors before export csv items in Teampass

## How to use

1. Download the csv with the items (if it redirects you to hacking attempt, click again on export objects and download, repeat until the file is downloaded).
2. Deletes the comments/description field (the csv generator change characters like ñ to N&ia for example), you can use excel or any spreadsheet processor (I also recommend removing commas and double-quotes from the file to avoid errors when converting the file).
3. Send the file to your linux system where the script is located.
4. Before use the script, make sure it has the proper execute permissions.
5. Type and execute:
>./script.sh fileToConvertName.csv

**A file named result will be created followed by the name of the file you used (like resultTeampass.csv), make sure everything is correct**


### [Link to the issue in Teampass Github](https://github.com/nilsteampassnet/TeamPass/issues/3133) 

## Note
Feel free to take the steps you deem appropriate to achieve a better conversion and share it! :D
