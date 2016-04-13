#!/bin/sh

cd /var/data
bundle exec rake unicorn:stop
