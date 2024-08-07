#!/bin/sh

echo ""
echo "START install.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh



# Prepare
su -c "sh $BASEDIRPATH/00-prepare.sh"

# User
su -c "sh $BASEDIRPATH/01-user.sh"

# nodejs
su -c "sh $BASEDIRPATH/02-nodejs.sh" - $USER_NAME

# couchdb install
su -c "sh $BASEDIRPATH/03-couchdb.sh" - $USER_NAME

# couchdb config
su -c "sh $BASEDIRPATH/04-couchdb-configure.sh" - $USER_NAME

# redis install
su -c "sh $BASEDIRPATH/05-redis.sh" - $USER_NAME

# redis config
su -c "sh $BASEDIRPATH/06-redis-configure.sh" - $USER_NAME

# couchbox install
su -c "sh $BASEDIRPATH/07-couchbox.sh" - $USER_NAME

# couchbox config
su -c "sh $BASEDIRPATH/08-couchbox-configure.sh" - $USER_NAME

# nginx install
su -c "sh $BASEDIRPATH/09-nginx.sh" - $USER_NAME

# nginx config
su -c "sh $BASEDIRPATH/10-nginx-config.sh" - $USER_NAME

# install couch-photon and create log DB
su -c "sh $BASEDIRPATH/11-photon.sh" - $USER_NAME

# ufw config
su -c "sh $BASEDIRPATH/12-ufw.sh" - $USER_NAME

# test if couchbox is running
su -c "sh $BASEDIRPATH/99-test.sh" - $USER_NAME

echo ""
echo "DONE install.sh"
echo ""
exit 0
