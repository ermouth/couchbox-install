#!/bin/sh

echo ""
echo "START 01-user.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh


# vars
if [ -z ${USER_NAME+x} ]; then USER_NAME=couchbox; else echo "USER_NAME is set to '$USER_NAME'"; fi
USER_DIR=/home/$USER_NAME


# add user
mkdir $USER_DIR
groupadd couchbox
useradd -d $USER_DIR -g couchbox $USER_NAME
chown -R $USER_NAME:couchbox $USER_DIR
usermod -aG sudo $USER_NAME


# add user to sudores
sudo echo "$USER_NAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers


echo "DONE 01-user.sh"
exit 0
