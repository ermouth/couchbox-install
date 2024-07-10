#!/bin/sh

# This script is not intended to be started directly,
# edit below data before starting Couchbox install 

# Root dir, better do not touch
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)


# Proxy user to install components not as root.
# Installer creates /home/%USER_NAME/services/couchbox
# where Couchbox service js code is located
USER_NAME=couchbox

# Node name, used in multinode systems
NODE_NAME=n1

# User with _admin access to CouchDB, 
# created in CouchDB during install.
# The user is used by Couchbox to access Couch.
COUCHDB_USER=couchbox
COUCHDB_PASS=couchbox

# CouchDB secret key.
# You can set one or it will be generated.
# COUCHDB_SECRET=13654715ddd9d7f36e4caf54592be889

# CouchDB port config, better kept intact
COUCHDB_PORT=5984
# COUCHDB_SSL_PORT=6984

# Redis password, set after install. Couchbox
# talks to Redis using this password.
REDIS_PASS=couchbox

# Sets env var for node
NODE_ENV=production

# Sets up logging into CouchDB
LOGGER_DB=log
LOGGER_DB_SAVE=true
LOGGER_BULK_SIZE=100

COUCHBOX_JSON=$BASEDIR/couchbox.json
COUCHBOX_DOCS=$BASEDIR/couchbox=_design-demo.json
