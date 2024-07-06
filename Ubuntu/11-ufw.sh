#!/bin/sh

echo ""
echo "START 11-ufw.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh

# update & install ufw
sudo apt-get update -y
sudo apt-get install ufw -y

# allow ssh
sudo ufw allow 22

# allow http & https
sudo ufw allow 80
sudo ufw allow 443

# allow redis-commander
sudo ufw allow 8881

# allow api proxy: !!! FOR DEBUG ONLY
sudo ufw allow 8888
echo ""
echo "===== DEBUG 8888 PORT IS OPEN! =====" 
echo "Close it by 'sudo ufw deny 8888' if it is no more needed."
echo ""

# enable ufw
sudo ufw --force enable


echo "DONE 11-ufw.sh"
exit 0
