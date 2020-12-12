#!/bin/bash -xe

#Install memcached and then remove it. Memcached is not actually needed. We install amazon-elasticache-cluster-client.so instead. However Moodle does not detect memcached is installed. Therefore, this tricks Moodle into thinking it is installed.
sudo yum install -y php-pecl-memcached
sudo yum remove -y php-pecl-memcached

wget -P /tmp/ https://elasticache-downloads.s3.amazonaws.com/ClusterClient/PHP-7.3/latest-64bit
tar -xf '/tmp/latest-64bit' 
mv amazon-elasticache-cluster-client.so /tmp/
cp '/tmp/amazon-elasticache-cluster-client.so' /usr/lib64/php/modules/
if [ ! -f /etc/php.d/50-memcached.ini ]; then
    touch /etc/php.d/50-memcached.ini
fi
echo 'extension=/usr/lib64/php/modules/amazon-elasticache-cluster-client.so;' >> /etc/php.d/50-memcached.ini
echo 'extension=igbinary.so;' >> /etc/php.d/50-memcached.ini

#update Moodle source to use DYNAMIC_CLIENT_MODE so Moodle can detect changes to the elasticache cluster membership
sed -i '/\$this->options\[Memcached::OPT_BUFFER_WRITES\] = \$bufferwrites;/a \ \ \ \ \ \ \ \ $this->options[Memcached::OPT_CLIENT_MODE] = Memcached::DYNAMIC_CLIENT_MODE;' /var/www/moodle/html/cache/stores/memcached/lib.php
