#!/bin/sh

echo ""
echo "START 07-couchbox.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh


# deps
sudo apt-get install git sendmail libjpeg-progs -y


mkdir ~/services
mkdir ~/logs

sudo mkdir /var/log/couchbox
sudo chown -R $USER_NAME:couchbox /var/log/couchbox
sudo chmod 770 /var/log/couchbox

ln -s /var/log/couchbox ~/logs/couchbox
ln -s /var/log/couchdb  ~/logs/couchdb


# clone repo
cd /home/$USER_NAME/services
git clone https://github.com/ermouth/couchbox


# install npm modules
cd couchbox
npm install


echo "DONE 07-couchbox.sh"
exit 0
