#!/bin/sh

echo ""
echo "START 00-prepare.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh


# update & install deps
apt-get update -y
apt-get upgrade -y
apt-get install build-essential curl -y


echo "DONE 00-prepare.sh"
exit 0
