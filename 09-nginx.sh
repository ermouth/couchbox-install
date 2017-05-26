#!/bin/sh

echo ""
echo "START 09-nginx.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh


# update & install nginx
sudo apt-get update -y
sudo apt-get install nginx -y


echo "DONE 09-nginx.sh"
exit 0
