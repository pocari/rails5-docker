#!/bin/sh

cd /var/data

#bundle exec rake unicorn:start
bundle exec puma \
  --bind unix:///tmp/puma.sock \
  --daemon

