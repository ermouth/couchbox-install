#!/bin/sh

echo ""
echo "START 03-couchdb.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh

# ubuntu codename
VERSION_CODENAME=focal

# add couchdb repo & update
sudo apt update && sudo apt install -y curl apt-transport-https gnupg
curl https://couchdb.apache.org/repo/keys.asc | gpg --dearmor | sudo tee /usr/share/keyrings/couchdb-archive-keyring.gpg >/dev/null 2>&1
source /etc/os-release
echo "deb [signed-by=/usr/share/keyrings/couchdb-archive-keyring.gpg] https://apache.jfrog.io/artifactory/couchdb-deb/ ${VERSION_CODENAME} main" \
    | sudo tee /etc/apt/sources.list.d/couchdb.list >/dev/null

# install couchdb
sudo apt update
sudo apt install -y couchdb

# stop service
sudo service couchdb stop

# fix permissions
sudo chown -R couchdb:couchdb /opt/couchdb
sudo chown -R couchdb:couchdb /var/log/couchdb

sudo chmod -R 0770 /opt/couchdb
sudo chmod -R 0770 /var/log/couchdb

sudo chmod 664 /opt/couchdb/etc/local.ini
sudo chmod 775 /opt/couchdb/etc/local.d


# add current user to couchdb group
usermod -aG couchdb $USER_NAME


echo "DONE 03-couchdb.sh"
exit 0
