#!/bin/bash

chown -R www-data:www-data /usr/share/nginx/html

echo "refreshing packages..."
opkg-make-index . > Packages
rm Packages.gz
gzip Packages
echo "done, launching server"

exec nginx-debug -g 'daemon off;'
