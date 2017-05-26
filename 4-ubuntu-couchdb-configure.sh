#!/bin/sh

echo ""
echo "START 4-ubuntu-couchdb-configure.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh

# vars
if [ -z ${COUCHDB_USER+x} ]; then COUCHDB_USER=couchbox; else echo "COUCHDB_USER is set to '$COUCHDB_USER'"; fi
if [ -z ${COUCHDB_PASS+x} ]; then COUCHDB_PASS=couchbox; else echo "COUCHDB_PASS is set to '$COUCHDB_PASS'"; fi
if [ -z ${COUCHDB_PORT+x} ]; then COUCHDB_PORT=5984; else echo "COUCHDB_PORT is set to '$COUCHDB_PORT'"; fi
if [ -z ${COUCHDB_SSL_PORT+x} ]; then COUCHDB_SSL_PORT=6984; else echo "COUCHDB_SSL_PORT is set to '$COUCHDB_SSL_PORT'"; fi
if [ -z ${COUCHDB_LOCALE+x} ]; then COUCHDB_LOCALE=RU; else echo "COUCHDB_LOCALE is set to '$COUCHDB_LOCALE'"; fi
if [ -z ${COUCHDB_UUID+x} ]; then COUCHDB_UUID=$(dbus-uuidgen); else echo "COUCHDB_UUID is set to '$COUCHDB_UUID'"; fi


# stop couchdb
sudo service couchdb stop


# create SSL certs
sudo mkdir /etc/couchdb/cert
sudo openssl genrsa -out /etc/couchdb/cert/couch_key.pem 4096
sudo openssl req -new -x509 -key /etc/couchdb/cert/couch_key.pem -out /etc/couchdb/cert/couch_cert.pem -days 1095 -subj "/C=$COUCHDB_LOCALE"


# create local.ini
cat <<EOF | sudo tee /etc/couchdb/local.ini
; CouchDB Configuration Settings

; Custom settings should be made in this file. They will override settings
; in default.ini, but unlike changes made to default.ini, this file won't be
; overwritten on server upgrade.

[couchdb]
;max_document_size = 4294967296 ; bytes
uuid = $COUCHDB_UUID

[httpd]
port = $COUCHDB_PORT
bind_address = 0.0.0.0
; Options for the MochiWeb HTTP server.
;server_options = [{backlog, 128}, {acceptor_pool_size, 16}]
; For more socket options, consult Erlang's module 'inet' man page.
;socket_options = [{recbuf, 262144}, {sndbuf, 262144}, {nodelay, true}]

; Uncomment next line to trigger basic-auth popup on unauthorized requests.
;WWW-Authenticate = Basic realm="administrator"

; Uncomment next line to set the configuration modification whitelist. Only
; whitelisted values may be changed via the /_config URLs. To allow the admin
; to change this value over HTTP, remember to include {httpd,config_whitelist}
; itself. Excluding it from the list would require editing this file to update
; the whitelist.
;config_whitelist = [{httpd,config_whitelist}, {log,level}, {etc,etc}]

[query_servers]
;nodejs = /usr/local/bin/couchjs-node /path/to/couchdb/share/server/main.js


[httpd_global_handlers]
;_google = {couch_httpd_proxy, handle_proxy_req, <<"http://www.google.com">>}

[couch_httpd_auth]
; If you set this to true, you should also uncomment the WWW-Authenticate line
; above. If you don't configure a WWW-Authenticate header, CouchDB will send
; Basic realm="server" in order to prevent you getting logged out.
; require_valid_user = false
timeout = 172800

[log]
;level = debug

[log_level_by_module]
; In this section you can specify any of the four log levels 'none', 'info',
; 'error' or 'debug' on a per-module basis. See src/*/*.erl for various
; modules.
;couch_httpd = error


[os_daemons]
; For any commands listed here, CouchDB will attempt to ensure that
; the process remains alive. Daemons should monitor their environment
; to know when to exit. This can most easily be accomplished by exiting
; when stdin is closed.
;foo = /path/to/command -with args

[daemons]
; enable SSL support by uncommenting the following line and supply the PEM's below.
; the default ssl port CouchDB listens on is 6984
httpsd = {couch_httpd, start_link, [https]}

[ssl]
cert_file = /etc/couchdb/cert/couch_cert.pem
key_file = /etc/couchdb/cert/couch_key.pem
;password = somepassword
; set to true to validate peer certificates
verify_ssl_certificates = false
; Path to file containing PEM encoded CA certificates (trusted
; certificates used for verifying a peer certificate). May be omitted if
; you do not want to verify the peer.
;cacert_file = /full/path/to/cacertf
; The verification fun (optional) if not specified, the default
; verification fun will be used.
;verify_fun = {Module, VerifyFun}
; maximum peer certificate depth
ssl_certificate_max_depth = 1
port = $COUCHDB_SSL_PORT

; To enable Virtual Hosts in CouchDB, add a vhost = path directive. All requests to
; the Virual Host will be redirected to the path. In the example below all requests
; to http://example.com/ are redirected to /database.
; If you run CouchDB on a specific port, include the port number in the vhost:
; example.com:5984 = /database
[vhosts]
;example.com = /database/

[update_notification]
;unique notifier name=/full/path/to/exe -with "cmd line arg"

; To create an admin account uncomment the '[admins]' section below and add a
; line in the format 'username = password'. When you next start CouchDB, it
; will change the password to a hash (so that your passwords don't linger
; around in plain-text files). You can add more admin accounts with more
; 'username = password' lines. Don't forget to restart CouchDB after
; changing this.
[admins]
$COUCHDB_USER=$COUCHDB_PASS

EOF


# start couchdb
sudo service couchdb start


echo "DONE 4-ubuntu-couchdb-configure.sh"
exit 0
