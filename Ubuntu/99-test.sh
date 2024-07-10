#!/bin/sh

echo ""
echo "###########################################################"
echo "START 99-test.sh"
echo ""

# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh

# vars
if [ -z ${COUCHDB_USER+x} ]; then COUCHDB_USER=couchbox; fi
if [ -z ${COUCHDB_PASS+x} ]; then COUCHDB_PASS=couchbox; fi
if [ -z ${COUCHDB_PORT+x} ]; then COUCHDB_PORT=5984; fi
if [ -z ${LOGGER_DB+x} ]; then LOGGER_DB=log; fi

echo "Testing if Couchbox API works..."
echo ""
echo `curl --no-progress-meter http://localhost/index`
echo ""
echo " ^^^ You must see JSON with Welcome to Couchbox phrase."
echo "     If you see it Couchbox API is running."

echo ""
echo "-------------------"
echo ""

echo "Testing if Couchbox hooks are watching changes..."
echo ""
couch="http://$COUCHDB_USER:$COUCHDB_PASS@127.0.0.1:$COUCHDB_PORT"
head="-H Content-Type:application/json"
curl -s -o /dev/null $head -X PUT -d '{"name":"installer test"}' $couch/couchbox/InstallerHookTest 
sleep .5
echo `curl --no-progress-meter $couch/couchbox/Created_by_Couchbox_test_hook`
echo ""
echo ' ^^^ You must see JSON with _id:"Created_by_Couchbox_test_hook".'
echo '     That doc was created by demo hook which triggered with a doc '
echo '     {name:"installer test"} just saved into couchbox bucket.' 

echo ""
echo "DONE 99-test.sh"
echo ""

exit 0