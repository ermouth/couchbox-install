#!/bin/sh

echo ""
echo "START install.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh



# Prepare
su -c "sh $BASEDIRPATH/0-root-prepare.sh"

# User
su -c "sh $BASEDIRPATH/1-root-user.sh"

# nodejs
su -c "sh $BASEDIRPATH/2-ubuntu-nodejs.sh" - $USER_NAME

# couchdb install
su -c "sh $BASEDIRPATH/3-ubuntu-couchdb.sh" - $USER_NAME

# couchdb config
su -c "sh $BASEDIRPATH/4-ubuntu-couchdb-configure.sh" - $USER_NAME

# redis install
su -c "sh $BASEDIRPATH/5-ubuntu-redis.sh" - $USER_NAME

# redis config
su -c "sh $BASEDIRPATH/6-ubuntu-redis-configure.sh" - $USER_NAME

# couchbox install
su -c "sh $BASEDIRPATH/7-ubuntu-couchbox.sh" - $USER_NAME

# couchbox config
su -c "sh $BASEDIRPATH/8-ubuntu-couchbox-configure.sh" - $USER_NAME

# nginx install
su -c "sh $BASEDIRPATH/9-ubuntu-nginx.sh" - $USER_NAME

# nginx config
su -c "sh $BASEDIRPATH/10-ubuntu-nginx-config.sh" - $USER_NAME

# ufw config
su -c "sh $BASEDIRPATH/11-ubuntu-ufw.sh" - $USER_NAME



echo "DONE install.sh"
exit 0
