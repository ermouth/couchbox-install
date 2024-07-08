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

# make log db
if [ -z ${COUCHDB_USER+x} ]; then COUCHDB_USER=couchbox; else echo "COUCHDB_USER is set to '$COUCHDB_USER'"; fi
if [ -z ${COUCHDB_PASS+x} ]; then COUCHDB_PASS=couchbox; else echo "COUCHDB_PASS is set to *****"; fi
if [ -z ${COUCHDB_PORT+x} ]; then COUCHDB_PORT=5984; else echo "COUCHDB_PORT is set to '$COUCHDB_PORT'"; fi
if [ -z ${LOGGER_DB+x} ]; then LOGGER_DB=log; else echo "Couchbox log DB is set to '$LOGGER_DB'"; fi

COUCH="http://$COUCHDB_USER:$COUCHDB_PASS@127.0.0.1:$COUCHDB_PORT"
HEAD="-H Content-Type:application/json"
curl $HEAD -X PUT $COUCH/$LOGGER_DB
echo "Created log DB for Couchbox"

# directories and links, if not present
mkdir ~/services
mkdir ~/logs

sudo mkdir /var/log/couchbox
sudo chown -R $USER_NAME:couchbox /var/log/couchbox
sudo chmod 770 /var/log/couchbox

ln -s /var/log/couchbox ~/logs/couchbox
ln -s /var/log/couchdb  ~/logs/couchdb


# clone repo
cd /home/$USER_NAME/services
git clone https://github.com/ermouth/couchbox.git


# install npm modules
cd couchbox
npm install


echo "DONE 07-couchbox.sh"
exit 0
