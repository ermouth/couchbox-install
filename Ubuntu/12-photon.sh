#!/bin/sh

echo ""
echo "START 12-photon.sh"

# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh

# vars
if [ -z ${COUCHDB_USER+x} ]; then COUCHDB_USER=couchbox; else echo "COUCHDB_USER is set to '$COUCHDB_USER'"; fi
if [ -z ${COUCHDB_PASS+x} ]; then COUCHDB_PASS=couchbox; else echo "COUCHDB_PASS is set to '$COUCHDB_PASS'"; fi
if [ -z ${COUCHDB_PORT+x} ]; then COUCHDB_PORT=5984; else echo "COUCHDB_PORT is set to '$COUCHDB_PORT'"; fi
if [ -z ${LOGGER_DB+x} ]; then LOGGER_DB=log; else echo "Couchbox log DB is set to '$LOGGER_DB'"; fi

# install Photon
couch="http://$COUCHDB_USER:$COUCHDB_PASS@127.0.0.1:$COUCHDB_PORT"
head="-H Content-Type:application/json"
curl $head -X PUT $couch/photon
curl https://raw.githubusercontent.com/ermouth/couch-photon/master/photon.json | \
curl $head -X PUT $couch/photon/_design/photon -d @- 
curl $head -X PUT $couch/photon/_security -d '{}' 

# create log DB
curl $head -X PUT $couch/$LOGGER_DB

couch=''; head='';

echo "Photon installed";
echo "Done 12-photon.sh"
echo ""

exit 0