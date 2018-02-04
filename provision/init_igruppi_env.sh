####################################################
# SETUP VHOST on APACHE2

# Setup igruppi vhost in default apache conf
rm /etc/apache2/sites-available/000-default.conf
cat << 'EOF' > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/igruppi/public
    <Directory /var/www/igruppi/public/>
        Options FollowSymLinks
        AllowOverride All
        Order allow,deny
        Allow from all
        Require all granted
    </Directory>
    ErrorLog ${APACHE_LOG_DIR}/error.log
    # Possible values include: debug, info, notice, warn, error, crit, alert, emerg.
    LogLevel warn
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

# Activate it
a2ensite 000-default

# Change user and group for apache
sed -i '/APACHE_RUN_USER/d' /etc/apache2/envvars
sed -i '/APACHE_RUN_GROUP/d' /etc/apache2/envvars

cat >> /etc/apache2/envvars <<'EOF'
# Apache user and group
export APACHE_RUN_USER=vagrant
export APACHE_RUN_GROUP=vagrant
EOF

# Fix premissions
if [ -d /var/lock/apache2 ]
    then
        chown -R vagrant:vagrant /var/lock/apache2
fi

# Enable rewrites
a2enmod rewrite

# Some changes to php.ini
sed -i 's/display_errors = Off/display_errors = On/g' /etc/php5/apache2/php.ini
sed -i 's/display_startup_errors = Off/display_startup_errors = On/g' /etc/php5/apache2/php.ini
# sed -i 's/error_reporting = E_ALL & ~E_DEPRECATED/error_reporting = E_ALL/g' /etc/php5/apache2/php.ini
sed -i 's/track_errors = Off/track_errors = On/g' /etc/php5/apache2/php.ini
sed -i 's/html_errors = Off/html_errors = On/g' /etc/php5/apache2/php.ini

# Restart services
service apache2 restart



####################################################
# SETUP DATABASE

# Create database
if [ -z `mysql -uroot -proot_password --skip-column-names --batch -e "SHOW DATABASES  LIKE 'igruppi'"` ]
    then
        mysql -uroot -proot_password -e "CREATE DATABASE igruppi"
        EMPTY_DB=true
fi

if [ "$EMPTY_DB" = true ] ; then
    mysql -uroot -proot_password igruppi < /var/www/igruppi/documentation/database/igruppi2_create-db.sql
    mysql -uroot -proot_password igruppi < /var/www/igruppi/documentation/database/igruppi2_update-db_1.sql
    mysql -uroot -proot_password igruppi < /var/www/igruppi/documentation/database/igruppi_data_anonymous.sql
fi

