#!/bin/sh

echo ""
echo "###########################################################"
echo "START 08-couchbox-configure.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh

# vars
if [ -z ${COUCHDB_USER+x} ]; then COUCHDB_USER=couchbox; else echo "COUCHDB_USER is set to '$COUCHDB_USER'"; fi
if [ -z ${COUCHDB_PASS+x} ]; then COUCHDB_PASS=couchbox; else echo "COUCHDB_PASS is set to *****"; fi
if [ -z ${COUCHDB_PORT+x} ]; then COUCHDB_PORT=5984; else echo "COUCHDB_PORT is set to '$COUCHDB_PORT'"; fi
if [ -z ${COUCHDB_SECRET+x} ]; then COUCHDB_SECRET=$(dbus-uuidgen); else echo "COUCHDB_SECRET is set to ********"; fi
if [ -z ${REDIS_PASS+x} ]; then REDIS_PASS=couchbox; else echo "REDIS_PASS is set to *****"; fi
if [ -z ${NODE_NAME+x} ]; then NODE_NAME=n1; else echo "NODE_NAME is set to '$NODE_NAME'"; fi
if [ -z ${NODE_ENV+x} ]; then NODE_ENV=production; else echo "NODE_ENV is set to '$NODE_ENV'"; fi

if [ -z ${COUCHBOX_JSON+x} ]; then COUCHBOX_JSON=; else echo "COUCHBOX_JSON is set to '$COUCHBOX_JSON'"; fi
if [ -z ${COUCHBOX_DOCS+x} ]; then COUCHBOX_DOCS=; else echo "COUCHBOX_DOCS is set to '$COUCHBOX_DOCS'"; fi


# logrotate
cat <<EOF | sudo tee /etc/logrotate.d/couchbox
/var/log/couchbox/*.log {
  weekly
  rotate 10
  copytruncate
  delaycompress
  compress
  notifempty
  missingok
}
EOF


# systemd service script
cat <<EOF | sudo tee /etc/systemd/system/couchbox.service
[Unit]
Description=Couchbox
Wants=network.target couchdb.service redis.service
After=network.target couchdb.service redis.service

[Service]
User=$USER_NAME
Group=couchbox
ExecStart=/bin/sh -c '/usr/bin/node index.js > /var/log/couchbox/couchbox.log 2>&1'
WorkingDirectory=/home/$USER_NAME/services/couchbox
Restart=always
RestartSec=10
Environment=NODE_ENV=$NODE_ENV DB_USER=$COUCHDB_USER DB_PASS=$COUCHDB_PASS LOGGER_DB=$LOGGER_DB LOGGER_DB_SAVE=$LOGGER_DB_SAVE LOGGER_BULK_SIZE=$LOGGER_BULK_SIZE

[Install]
WantedBy=multi-user.target

EOF


# configure couchbox
node /home/$USER_NAME/services/couchbox/setup.js $COUCHBOX_JSON -D $COUCHBOX_DOCS -n $NODE_NAME -u $COUCHDB_USER -p $COUCHDB_PASS -r $REDIS_PASS -A 127.0.0.1 -P $COUCHDB_PORT -s $COUCHDB_SECRET


# start couchbox & add to startup
sudo service couchbox start
sudo systemctl enable couchbox


echo "DONE 08-couchbox-configure.sh"
exit 0
