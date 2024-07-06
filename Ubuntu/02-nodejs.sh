#!/bin/sh

echo ""
echo "START 02-nodejs.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh


# install nodejs
# curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
curl -s https://deb.nodesource.com/setup_16.x | sudo bash
sudo apt install build-essential -y
sudo apt install nodejs -y

npm -v
sudo chown -R $USER_NAME:couchbox /home/$USER_NAME/.config

sudo npm -g update
sudo npm -g update npm


echo "DONE 02-nodejs.sh"
exit 0
