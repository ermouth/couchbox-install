#!/bin/sh

# config root dir
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)


# Proxy user to install components not on behalf of root
USER_NAME=couchbox

# Node name, used in multinode systems
NODE_NAME=cb

# User with _admin access, created in CouchDB after installation.
# The user is also used by Couchbox to access CouchDB.
COUCHDB_USER=couchbox
COUCHDB_PASS=couchbox

# CouchDB secret key
# COUCHDB_SECRET=13654715ddd9d7f36e4caf54592be889

# CouchDB port config, better kept intact
COUCHDB_PORT=5984
# COUCHDB_SSL_PORT=6984

# Redis pwd, set after installation. Couchbox
# fetches Redis using this pwd.
REDIS_PASS=couchbox

# Sets env var for node
NODE_ENV=production

# Sets up logging into CouchDB
LOGGER_DB=log
LOGGER_DB_SAVE=true
LOGGER_BULK_SIZE=100

COUCHBOX_JSON=$BASEDIR/couchbox.json
COUCHBOX_DOCS=$BASEDIR/couchbox=_design-demo.json
