#!/bin/sh

echo ""
echo "START 6-ubuntu-redis-configure.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh

# vars
if [ -z ${REDIS_PASS+x} ]; then REDIS_PASS=couchbox; else echo "REDIS_PASS is set to '$REDIS_PASS'"; fi


# make redis dirs
sudo mkdir /etc/redis
sudo cp /tmp/redis-stable/redis.conf /etc/redis


# update redis.conf
sudo sed -i 's/pidfile \/var\/run\/redis_6379.pid/pidfile \/var\/run\/redis.pid/g' /etc/redis/redis.conf
sudo sed -i 's/supervised no/supervised systemd/g' /etc/redis/redis.conf
sudo sed -i "s/# requirepass foobared/requirepass $REDIS_PASS/g" /etc/redis/redis.conf
sudo sed -i "s/dir .\//dir \/var\/lib\/redis/g" /etc/redis/redis.conf


# fix permissions & add user redis
sudo mkdir /var/lib/redis
sudo adduser --system --group --no-create-home redis
sudo chown redis:redis /var/lib/redis
sudo chmod 770 /var/lib/redis


# systemd service script
cat <<EOF | sudo tee /etc/systemd/system/redis.service
[Unit]
Description=Redis In-Memory Data Store
Wants=network.target
After=network.target

[Service]
User=redis
Group=redis
ExecStart=/usr/local/bin/redis-server /etc/redis/redis.conf
ExecStop=/usr/local/bin/redis-cli shutdown
Restart=always

[Install]
WantedBy=multi-user.target

EOF


# start redis
sudo service redis start
# add to startup
sudo systemctl enable redis


echo "DONE 6-ubuntu-redis-configure.sh"
exit 0
