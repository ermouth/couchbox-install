#!/bin/sh

echo ""
echo "START 02-nodejs.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh


# install nodejs 7.x
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
sudo apt-get install -y nodejs


echo "DONE 02-nodejs.sh"
exit 0