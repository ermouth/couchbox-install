#!/bin/sh

echo ""
echo "START 0-root-prepare.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh


# update & install deps
apt-get update -y
apt-get upgrade -y
apt-get install build-essential curl -y


echo "DONE 0-root-prepare.sh"
exit 0
