#!/bin/sh

(cd /var/data && bundle install)

/usr/bin/monit -I -c /etc/monit/monitrc

