# <img align="right" src="https://cdn.cloudwall.me/couchbox/couchbox-github.svg" /> Couchbox install for Ubuntu 20

This set of scripts installs and starts CouchDB, Redis, redis-commander, nginx, nodejs, ufw 
and Couchbox over clean Ubuntu. Installer was tested on Ubuntu 20 and 22. 

You can either clone this repo or download 
[couchbox-install-master.zip](https://github.com/ermouth/couchbox-install/archive/refs/heads/master.zip) 
into temp folder and unpack it. All stuff is located in `couchbox-install/Ubuntu` folder.

## Preconfigure

To preconfigure your Couchbox tune `config.sh` script, then if necessary `nginx.conf`, 
and then `couchbox.json`. If you already have some components installed comment them out from 
`install.sh` script, it’s very simple and easy to follow.

Couchbox absolute minimum is 2 core CPU system with 2 Gb of RAM. 

## Installation

__IMPORTANT: to run installer type `sudo sh install.sh`.__ Do not run install.sh directly 
from bash or zsh, it will likely fail. Also do not start numbered scripts manually.

Scripts will download all dependencies and components, then install and start them.
Also scripts configure autostarts. Setup takes 5–10 minutes normally, fast internet 
connection and at least 2Gb of RAM required.

Installer runs simple test at the end. The test clearly shows if both Couchbox API 
and hooks are installed and running.

Watch 8 min [YouTube video](https://youtu.be/SzRzMZVN5NU) showing installation process.

## CouchDB during installation

CouchDB installer may ask you several questions during the process. Don’t bother to change 
bind address, Couchbox resets it later, but do provide admin password and whatever you 
like random erlang cookie. You need not memorize erlang cookie if no cluster is planned. 

Couchbox installer creates 3 buckets in CouchDB: `log` for reflecting logs, `couchbox` for 
demo which used for testing in the end of installation process, and also `photon` for 
Photon admin panel for CouchDB.

Also Couchbox installer adds an admin into CouchDB; admin’s credentials are defined 
in `config.sh`.

## After installation

Installer opens port 8888 which is a direct proxy to CouchDB provided by Couchbox. You can 
access CouchDB admin panel Photon at `http://NODE_IP:8888/photon/_design/photon/index.html`. 

Couchbox configuration lives in CouchDB config under `couchbox`-prefixed keys, so you can 
modify them using CouchDB admin panel.

To turn on Redis Commander tune `couchbox/redis_commander` key, set `"active":` to `true`,
and save updated config. Then open 8881 port with `sudo ufw allow 8881` in your terminal. 
Redis Commander is now visisble at `http://NODE_IP:8881`. Redis Commander logs into 
main Couchbox log since it runs as a Couchbox worker.

#### Logs:
```bash
# Couchbox
sudo tail -50 /var/log/couchbox/couchbox.log
# CouchDB
sudo tail -50  /opt/couchdb/var/log/couchdb.log
# Redis log
sudo tail -50 /var/log/redis/redis-server.log
# nginx logs
sudo tail -50 /var/log/nginx/access.log
sudo tail -50 /var/log/nginx/error.log
```

## Configuration files

#### config.sh

Follow comments inside the script.

#### nginx.conf

Re-configure nginx to set up SSL and bind a domain. Set up matching rules for paths 
routed to couchbox.

#### couchbox.json

Set up CORS, emergency notification email address (`couchbox.mail` section), nodename
and plugins config. 

-----------
(c) 2024 ermouth, ftescht. Couchbox and Couchbox-install are MIT licensed.