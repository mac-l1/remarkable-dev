#!/bin/bash

chown -R www-data:www-data /usr/share/nginx/html

opkg-make-index . > Packages
gzip Packages

exec nginx-debug -g 'daemon off;'
