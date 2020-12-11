#!/bin/bash -xe
wget -O /tmp/moodle.tgz https://download.moodle.org/download.php/direct/stable38/moodle-3.8.3.tgz
tar -xvzf /tmp/moodle.tgz --strip-components=1 -C /var/www/moodle/html/
wget -O /var/www/moodle/html/lib/aws.phar https://docs.aws.amazon.com/aws-sdk-php/v3/download/aws.phar
cp /tmp/config.php /var/www/moodle/html/config.php
chown -R root:apache /var/www/moodle/html
chown -R apache:apache /var/www/moodle/local