# Couchbox install for Ubuntu 14+

This set of scripts installs and starts CouchDB 1.6.1, Redis, nginx, nodejs, UFW 
and Couchbox over clean Ubuntu. You can a) clone this repo, or 
b) download  [archive.tar](https://gitlab.com/Couchbox/install/repository/archive.tar?ref=master) 
into temp folder and unpack it. 

Next, [preconfigure](#preconfigure) installation scripts and [run the sequence](#run). 
Scripts will download all dependencies and components, then install and start them.
Also scripts will configure all required autostarts. 

Fast internet connection and at least 2Gb of RAM required (npm is hungry, sorry).

## Preconfigure

Setup params in:

#### config.sh

Follow comments inside the script. Uncomment log-related lines to have log in CouchDB 
bucket (may be useful for multinode log aggregation).

#### nginx.conf

Re-configure nginx to set up SSL and bind a domain. Set up matching rules for paths 
routed to couchbox.

#### couchbox.json

Set up CORS, emergency notification email address (`couchbox.mail` section), nodename
and plugins config.

## Run

Run install script, typing `sh install.sh` in appropriate folder. After installation
process finished, Couchbox is accessible at https://server:6984
