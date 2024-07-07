#!/bin/sh

echo ""
echo "START 04-couchdb-configure.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh

# vars
if [ -z ${COUCHDB_USER+x} ]; then COUCHDB_USER=couchbox; else echo "COUCHDB_USER is set to '$COUCHDB_USER'"; fi
if [ -z ${COUCHDB_PASS+x} ]; then COUCHDB_PASS=couchbox; else echo "COUCHDB_PASS is set to '$COUCHDB_PASS'"; fi
if [ -z ${COUCHDB_PORT+x} ]; then COUCHDB_PORT=5984; else echo "COUCHDB_PORT is set to '$COUCHDB_PORT'"; fi
if [ -z ${COUCHDB_LOCALE+x} ]; then COUCHDB_LOCALE=RU; else echo "COUCHDB_LOCALE is set to '$COUCHDB_LOCALE'"; fi
if [ -z ${COUCHDB_UUID+x} ]; then COUCHDB_UUID=$(dbus-uuidgen); else echo "COUCHDB_UUID is set to '$COUCHDB_UUID'"; fi
if [ -z ${COUCHDB_SECRET+x} ]; then COUCHDB_SECRET=$(dbus-uuidgen); else echo "COUCHDB_SECRET is set to '$COUCHDB_SECRET'"; fi


# stop couchdb
sudo service couchdb stop

# create local.ini
cat <<EOF | sudo tee /opt/couchdb/etc/local.ini
; CouchDB Configuration Settings

; Custom settings should be made in this file. They will override settings
; in default.ini, but unlike changes made to default.ini, this file won't be
; overwritten on server upgrade.

[admins]
$COUCHDB_USER=$COUCHDB_PASS

[couchdb]
max_document_size = 4294967296 ; bytes
os_process_timeout = 15000
uuid = $COUCHDB_UUID
users_db_security_editable = true

[csp]
attachments_enable = false
showlist_enable = false

[chttpd]
port = $COUCHDB_PORT
bind_address = 0.0.0.0
authentication_handlers = {chttpd_auth, cookie_authentication_handler}, {chttpd_auth, proxy_authentication_handler}, {chttpd_auth, default_authentication_handler}
enable_cors = true
secure_rewrites = false

[chttpd_auth]
secret = $COUCHDB_SECRET
proxy_use_secret = true
public_fields = pic,title,_attachments
require_valid_user = false
same_site = lax

[couch_httpd_auth]
timeout = 600001
secret = $COUCHDB_SECRET
require_valid_user = false
proxy_use_secret = true

[cluster]
q = 2
n = 1

[httpd]
port = 5986
bind_address = 127.0.0.1
enable_cors = true

[cors]
origins = http://localhost, http://127.0.0.1, http://localhost:5984, http://127.0.0.1:5984, http://localhost:8888
headers = accept, authorization, content-type, origin, referer, X-Auth-CouchDB-Roles, X-Auth-CouchDB-UserName, X-Auth-CouchDB-Token
methods = GET, POST, PUT, DELETE, OPTIONS, HEAD
credentials = true

[replicator]
update_docs = true

[indexers]
couch_mrview = true

[query_server_config]
reduce_limit = false

[log]
;level = debug

[vhosts]
;example.com = /database/

EOF


# start couchdb
sudo service couchdb start


echo "DONE 04-couchdb-configure.sh"
exit 0
