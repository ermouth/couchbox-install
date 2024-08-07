#!/bin/sh

echo ""
echo "###########################################################"
echo "START 12-photon.sh"
echo ""

# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh

# vars
if [ -z ${COUCHDB_USER+x} ]; then COUCHDB_USER=couchbox; fi
if [ -z ${COUCHDB_PASS+x} ]; then COUCHDB_PASS=couchbox; fi
if [ -z ${COUCHDB_PORT+x} ]; then COUCHDB_PORT=5984; fi

# install Photon
couch="http://$COUCHDB_USER:$COUCHDB_PASS@127.0.0.1:$COUCHDB_PORT"
head="-H Content-Type:application/json"
curl $head -X PUT $couch/photon
curl https://raw.githubusercontent.com/ermouth/couch-photon/master/photon.json | \
  curl $head -X PUT $couch/photon/_design/photon -d @- 

curl $head -X PUT $couch/photon/_security -d '{}' 

echo "Photon installed";
echo "Done 12-photon.sh"
echo ""

exit 0