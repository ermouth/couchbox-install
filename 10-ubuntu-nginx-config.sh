#!/bin/sh

echo ""
echo "START 10-ubuntu-nginx-config.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh


# stop nginx
sudo service nginx stop

# remove defaults
sudo rm -f /etc/nginx/sites-enabled/default
sudo rm -f /etc/nginx/sites-available/default

# copy nginx config
sudo cp $BASEDIR/nginx.conf /etc/nginx/sites-available/couchbox
sudo ln -s /etc/nginx/sites-available/couchbox /etc/nginx/sites-enabled/couchbox

# start nginx
sudo service nginx start


echo "DONE 10-ubuntu-nginx-config.sh"
exit 0
