#!/bin/bash -xe
# create hidden opcache directory locally & change owner to apache
if [ ! -d /var/www/.opcache ]; then                    
    mkdir -p /var/www/.opcache
fi
#Ensure opcache is enabled and add settings recomended by moodle at https://docs.moodle.org/34/en/OPcache
sed -i 's/;opcache.file_cache=.*/opcache.file_cache=\/var\/www\/.opcache/' /etc/php.d/10-opcache.ini
sed -i 's/opcache.memory_consumption=.*/opcache.memory_consumption=512/' /etc/php.d/10-opcache.ini
sed -i 's/opcache.max_accelerated_files=.*/opcache.max_accelerated_files=8000/' /etc/php.d/10-opcache.ini
sed -i 's/;opcache.revalidate_freq=.*/opcache.revalidate_freq=300/' /etc/php.d/10-opcache.ini
sed -i 's/;opcache.use_cwd=.*/opcache.use_cwd=1/' /etc/php.d/10-opcache.ini
sed -i 's/;opcache.validate_timestamps=.*/opcache.validate_timestamps=1/' /etc/php.d/10-opcache.ini
sed -i 's/;opcache.save_comments=.*/opcache.save_comments=1/' /etc/php.d/10-opcache.ini
sed -i 's/;opcache.enable_file_override=.*/opcache.enable_file_override=60/' /etc/php.d/10-opcache.ini