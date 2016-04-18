#!/usr/bin/env bash

# The following configuration is base on your own application.

# DO NOT put your password or other classified information to this file!

# APP_KEY=`pwgen -c -n -s -1 32`
# DB_HOST="mysql" NOTE: see --link in README
# DB_DATABASE="micooz"
# DB_USERNAME="root"
# DB_PASSWORD=`pwgen -c -n -s -1 12`

MYSQL_USER="root"
MYSQL_PASSWORD="447826004"
MYSQL_HOST="mysql"

WORDPRESS_DB="wordpress"
WORDPRESS_DB_USER="wordpress"
WORDPRESS_DB_PASSWORD='pwgen -c -n -s -1 12'

#WORDPRESS_PASSWORD=$MYSQL_ENV_MYSQL_PASSWORD
chown -R www-data:www-data /www

sed -e "s/database_name_here/$WORDPRESS_DB/
s/username_here/$WORDPRESS_DB_USER/
s/password_here/$WORDPRESS_DB_PASSWORD/
s/localhost/$MYSQL_HOST/
/'AUTH_KEY'/s/put your unique phrase here/`pwgen -c -n -1 65`/
/'SECURE_AUTH_KEY'/s/put your unique phrase here/`pwgen -c -n -1 65`/
/'LOGGED_IN_KEY'/s/put your unique phrase here/`pwgen -c -n -1 65`/
/'NONCE_KEY'/s/put your unique phrase here/`pwgen -c -n -1 65`/
/'AUTH_SALT'/s/put your unique phrase here/`pwgen -c -n -1 65`/
/'SECURE_AUTH_SALT'/s/put your unique phrase here/`pwgen -c -n -1 65`/
/'LOGGED_IN_SALT'/s/put your unique phrase here/`pwgen -c -n -1 65`/
/'NONCE_SALT'/s/put your unique phrase here/`pwgen -c -n -1 65`/" /www/wp-config-sample.php > /www/wp-config.php

chown www-data:www-data /www/wp-config.php
mkdir -p /var/log/nginx
chown -R www-data:www-data /var/log/nginx

mysql -h$MYSQL_HOST -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE  IF NOT EXISTS  wordpress; GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%' IDENTIFIED BY '$WORDPRESS_DB_PASSWORD'; FLUSH PRIVILEGES;"

# This command will block the process so the container will not be closed.
tail -f
