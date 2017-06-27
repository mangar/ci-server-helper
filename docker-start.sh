#!/bin/bash

#
rm ./tmp/docker.pid
echo "[start] $(date)" >> ./tmp/docker.pid


#
# Clean up
#
rm -rf ./tmp/cache ./tmp/pids ./tmp/sessions ./tmp/sockets



#
# Setup
#
bundle install

sleep 5
rake db:create db:migrate db:seed




# bundle exec sidekiq -q default -q mailers -c 5&


#
# Running
#
echo "[finish] $(date)" >> ./tmp/docker.pid

rails server -p 3000 -b '0.0.0.0'
