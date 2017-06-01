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


sudo mkdir /home/$USER_NAME/services
sudo mkdir /var/log/couchbox
sudo ln -s /var/log/couchbox /home/$USER_NAME/logs

sudo chown -R $USER_NAME:couchbox /home/$USER_NAME/services
sudo chown -R $USER_NAME:couchbox /var/log/couchbox
sudo chmod 770 /var/log/couchbox


# clone repo
cd /home/$USER_NAME/services
# you can use your git account https://username:password@gitlab.com/Couchbox/couchbox.git
git clone git@gitlab.com:Couchbox/couchbox.git

# install npm modules
cd couchbox
npm install


echo "DONE 07-couchbox.sh"
exit 0
