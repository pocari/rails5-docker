#!/bin/sh

(cd /var/data && su www-data -c 'bundle install -j$(nproc)')

/usr/bin/monit -I -c /etc/monit/monitrc

