#!/bin/bash
mkdir -p var/www/html
cd var/www/html
echo "Hello, World!" > index.html
apt-get update -y
apt-get install -y nginx > /var/nginx.log
