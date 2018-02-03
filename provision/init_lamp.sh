#!/bin/bash

echo "PROVISIONING -> $1"

# MIGRATE from MySQL to MariaDB
apt-get install software-properties-common --assume-yes
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
apt-get update
debconf-set-selections <<< "mariadb-server mysql-server/root_password password root_password"
debconf-set-selections <<< "mariadb-server mysql-server/root_password_again password root_password"
apt-get install mariadb-server mariadb-client --assume-yes
# Apache2 and PHP
apt-get install apache2 php5 libapache2-mod-php5 \
    php5-mysqlnd php5-curl php5-gd php5-intl php-pear \
    php5-imagick php5-imap php5-mcrypt php5-memcache \
    php5-sqlite php5-xmlrpc --assume-yes

# Install phpMyAdmin
debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean false"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password app_pass"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password root_password"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password app_pass"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
apt-get install phpmyadmin --assume-yes

# Install GIT
apt-get install git-core git-flow --assume-yes


# ADD alias in bashrc
echo -e "\n# Jazzo aliases\nalias ll='ls -al'\nalias l='ls -al'" >> /home/vagrant/.bashrc
