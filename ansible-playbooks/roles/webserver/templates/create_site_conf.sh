#!/bin/bash -xe
amazon-linux-extras install -y php7.3 postgresql9.6 
yum install -y awslogs httpd php-pgsql php-gd php-soap php-intl php-mbstring php-xmlrpc php-zip
sed -i 's/memory_limit =.*/memory_limit = 2048M/' /etc/php.ini
if [ ! -f /etc/httpd/conf.d/moodle.conf ]; then                    
    touch /etc/httpd/conf.d/moodle.conf
    echo 'ServerName 127.0.0.1:80' >> /etc/httpd/conf.d/moodle.conf
    echo 'DocumentRoot /var/www/moodle/html' >> /etc/httpd/conf.d/moodle.conf
    echo '<Directory /var/www/moodle/html>' >> /etc/httpd/conf.d/moodle.conf
    echo '  Options Indexes FollowSymLinks' >> /etc/httpd/conf.d/moodle.conf
    echo '  AllowOverride All' >> /etc/httpd/conf.d/moodle.conf
    echo '  Require all granted' >> /etc/httpd/conf.d/moodle.conf
    echo '</Directory>' >> /etc/httpd/conf.d/moodle.conf
fi