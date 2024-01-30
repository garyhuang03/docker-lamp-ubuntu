#!/bin/bash

apt update && apt upgrade -y

# Set MySQL root password
MYSQL_ROOT_PASSWORD="root"

# Set phpMyAdmin password
PHPMYADMIN_PASSWORD="root"

# Set debconf selections for MySQL
echo "mariadb-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | debconf-set-selections
echo "mariadb-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | debconf-set-selections

# Install LAMP stack
apt update
apt install -y apache2 apache2-utils libapache2-mod-php
apt install -y mariadb-server
service mysql start
apt install -y php php-mysql

# Set up MySQL and create a database (optional)
# Note: Replace 'your_database' with the desired database name
# sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE your_database;"

# Create Database administrator
DB_ADMIN=admin
DB_ADMIN_PASSWORD=root
mariadb -e "CREATE USER '$DB_ADMIN';"
mariadb -e "ALTER USER '$DB_ADMIN' IDENTIFIED BY '$DB_ADMIN_PASSWORD';"
mariadb -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_ADMIN' WITH GRANT OPTION;"

# Install PhpMyAdmin
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $PHPMYADMIN_PASSWORD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $MYSQL_ROOT_PASSWORD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $PHPMYADMIN_PASSWORD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections

apt install -y phpmyadmin

# Set Apache2 configuration path
PHPMYADMIN_APACHE_CONF=/etc/apache2/sites-available/phpmyadmin.conf
echo "Include /etc/phpmyadmin/apache.conf" | tee -a $PHPMYADMIN_APACHE_CONF
a2ensite phpmyadmin.conf

# Restart Apache (adjust for your web server)
service apache2 restart
