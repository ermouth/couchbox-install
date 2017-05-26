#!/bin/sh

echo ""
echo "START 9-ubuntu-nginx.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh


# update & install nginx
sudo apt-get update -y
sudo apt-get install nginx -y


echo "DONE 9-ubuntu-nginx.sh"
exit 0
