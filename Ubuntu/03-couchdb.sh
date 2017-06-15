#!/bin/sh

echo ""
echo "START 03-couchdb.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh


# add couchdb repo & update
sudo add-apt-repository ppa:couchdb/stable -y
sudo apt-get update -y

# install deps
sudo apt-get install software-properties-common -y

# install couchdb
sudo apt-get install couchdb -y

# stop service
sudo service couchdb stop

# fix permissions
sudo chown -R couchdb:couchdb /usr/bin/couchdb
sudo chown -R couchdb:couchdb /etc/couchdb
sudo chown -R couchdb:couchdb /usr/share/couchdb
sudo chown -R couchdb:couchdb /var/log/couchdb

sudo chmod -R 0770 /usr/bin/couchdb
sudo chmod -R 0770 /etc/couchdb
sudo chmod -R 0770 /usr/share/couchdb
sudo chmod -R 0770 /var/log/couchdb

sudo chmod 664 /etc/couchdb/*.ini
sudo chmod 775 /etc/couchdb/*.d


# add current user to couchdb group
usermod -aG couchdb $USER_NAME


echo "DONE 03-couchdb.sh"
exit 0
