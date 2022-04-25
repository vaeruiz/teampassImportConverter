# Despliegue de Teampass versión 2.1.27.36

## Requisitos mínimos previos
- **Sistema operativo**: Preferiblemente Ubuntu server por tener mayor soporte, aunque también se puede trabajar con otras distribuciones GNU/Linux.
- **Dirección IP de máquina estática/fija.**
- **Pila LAMP (Linux, Apache, MySQL y PHP).**

## Configuración y despliegue
Se puede hacer uso del script incluido llamado deployteampass.sh para la configuración previa del servidor y el despliegue de la palicación, igualmente, se explicarán los pasos a seguir:

1. Descargar paquetes necesarios para el servidor (automatizado en el script).

>apt-get install apache2 mariadb-server php7.4 php7.4-cli libapache2-mod-php7.4 php7.4-mysql php7.4-curl php7.4-mbstring php7.4-bcmath php7.4-common php7.4-gd php7.4-xml php7.4-ldap php-ldap git wget unzip -y

2. Configurar archivo php.ini (automatizado en el script).

>nano /etc/php/7.4/apache2/php.ini

Buscar los siguientes parámetros y cambiarlos por los valores indicados:

    memory_limit = por memory_limit = 256M
    upload_max_filesize = por upload_max_filesize = 100M
    max_execution_time = por max_execution_time = 360
    ;date.timezone = por date.timezone = Europe/Madrid

3. Crear base de datos (automatizado en el script).

       mysql -u root
       ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOTPW';
       CREATE DATABASE teampass;
       GRANT ALL PRIVILEGES ON teampass.* TO teampass@localhost IDENTIFIED BY "ContraseñaDelUsuarioTeampass";
       exit;

4. Movernos al directorio /var/www/html, descargar Teampass 2.1.27.36, extraerlo y cambiar nombre (automatizado en el sript).

>cd /var/www/html

>wget https://github.com/nilsteampassnet/TeamPass/archive/refs/tags/2.1.27.36.zip

>unzip 2.1.27.36.zip

>mv "TeamPass-2.1.27.36" teampass

Se puede eliminar el .zip descargado ya que no lo vamos a utilizar más

5. Aplicar los permisos y usuario necesarios (automatizado en el script).

>chown -R www-data.www-data /var/www/html/teampass/

>chmod -R 775 /var/www/html/teampass/

6. Crear la carpeta sk y aplicar los permisos necesarios (automatizado en el script).

>mkdir /var/www/sk

>chmod 777 /var/www/sk



**Nota, a partir de aquí los pasos dejan de estar automatizados en el script**

7. Crear fichero de configuración para el servidor apache (se puede utilizar el que viene por defecto sustituyendo el contenido del mismo, pero es mejor conservarlo para futuras ocasiones de mantenimiento)

>nano /etc/apache2/sites-available/teampass.conf

    <VirtualHost *:80>
         ServerAdmin correo@administrador.com
         DocumentRoot /var/www/html/teampass   
         ServerName nombre.dns.com

         <Directory /var/www/html/teampass>    
              Options FollowSymlinks
              AllowOverride All
              Require all granted
         </Directory>  

         ErrorLog ${APACHE_LOG_DIR}/teampass_error.log
         CustomLog ${APACHE_LOG_DIR}/teampass_access.log combined

    </VirtualHost>
    
Después de haber configurado el servidor, habilitamos el fichero y reiniciamos el servidor apache
>a2ensite teampass


>systemctl restart apache2

# Post despliegue

Después de estos pasos, debemos completar la instalación a través del navegador web, así que nos dirigimos a la ip de la máquina servidora (a no ser que se haya configurado previamente un nombre dns en la máquina y un redireccionador).

Una vez en la página de instalación, le damos a next, pasaremos a configurar la url y la carpeta de instalación de Teampass, lo podemos dejar con los valores que tiene por defecto si nos conviene la configuración mostrada, le damos a Launch para que se configuren los directorios, y si no hay errores le damos a Next.

Lo siguiente será configurar la base de datos, la configuracion que se deja por defecto será la que se muestra a continuación:
   
    Database information:
    Database connection Information
    Host :	localhost
    DataBase name :	teampass (nombre de la base de datos creada en mysql)
    Login :	teampass (nombre de usuario que puede acceder a la base de datos en mysql)
    Password :	teampass (contraseña del usuario que puede acceder a la base de datos en mysql)
    Port : 3306
    
Presionar Launch para comprobar que realiza la conexión, si es exitosa, darle a Next.

En la siguiente configuración especificamos donde se almacenarán las claves (*Asolute path to SaltKey*, este directorio es muy importante, ya que es necesario para que se registren las contraseñas, es donde hemos creado el directorio sk), y la clave de la cuenta de administrador, presionar en Launch y si no hay errores, darle a Next.

En este paso, le damos a Launch directamente para que se conecte a la base de datos y cree las tablas de datos, cuando termine, le damos a Next.

Este será el último paso, una vez más le damos a Launch para que finalice la instalación y le damos a Next para que nos lleve a la última página de instalación.

En esta página, le damos a Move to home page y lo que tendremos que hacer será iniciar sesión con nuestra cuenta de administrador, el usuario administrador es admin.

## Posibles errores

Si a la hora de hacer una migración de un teampass a otro no se ven las contraseñas, hay que localizar los ficheros que se encuentran en el directorio sk (aún por determinar en la máquina servidora del PITA), y moverlos al directorio sk del servidor con el que se está trabajando.

## Nota. Se ha incluido una instruccion a modo de debug para mostrar todos los comandos que se están ejecutando, para activarlo, descomentar la línea set -x.


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
