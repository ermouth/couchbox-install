#!/bin/sh

echo ""
echo "START 11-ufw.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh

# vars
if [ -z ${COUCHDB_SSL_PORT+x} ]; then COUCHDB_SSL_PORT=6984; else echo "COUCHDB_SSL_PORT is set to '$COUCHDB_SSL_PORT'"; fi


# update & install ufw
sudo apt-get update -y
sudo apt-get install ufw -y

# allow ssh
sudo ufw allow 22

# allow http & https
sudo ufw allow 80
sudo ufw allow 443

# allow https couchdb
sudo ufw allow $COUCHDB_SSL_PORT

# allow redis-commander
sudo ufw allow 8881

# allow api proxy for debug
sudo ufw allow 8888

# enable ufw
sudo ufw --force enable


echo "DONE 11-ufw.sh"
exit 0
