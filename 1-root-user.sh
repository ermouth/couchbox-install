#!/bin/sh

echo ""
echo "START 1-root-user.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh

# vars
if [ -z ${USER_NAME+x} ]; then USER_NAME=ubuntu; else echo "USER_NAME is set to '$USER_NAME'"; fi
USER_DIR=/home/$USER_NAME


# add user
mkdir $USER_DIR
useradd -d $USER_DIR $USER_NAME
chown -R $USER_NAME: $USER_DIR
usermod -aG sudo $USER_NAME


# add user to sudores
echo "$USER_NAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers


echo "DONE 1-root-user.sh"
exit 0
