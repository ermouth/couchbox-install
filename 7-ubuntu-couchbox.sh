#!/bin/sh

echo ""
echo "START 7-ubuntu-couchbox.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh


# deps
sudo apt-get install git sendmail libjpeg-progs -y

# add couchbox user dirs
sudo mkdir /home/couchbox
sudo mkdir /home/couchbox/services
sudo mkdir /var/log/couchbox
sudo ln -s /var/log/couchbox /home/couchbox/logs

# add couchbox user
sudo adduser --home /home/couchbox --system --group couchbox
sudo chown -R couchbox:couchbox /home/couchbox
sudo chown -R couchbox:couchbox /var/log/couchbox
sudo chmod 770 /var/log/couchbox


# clone repo
cd /home/couchbox/services
# you can use your git account  https://username:password@gitlab.com/ermouth/couchbox.git
sudo git clone git@gitlab.com:ermouth/couchbox.git


# install npm modules
cd couchbox
sudo npm install


echo "DONE 7-ubuntu-couchbox.sh"
exit 0
