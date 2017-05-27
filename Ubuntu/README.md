# Couchbox install for Ubuntu 14+

This set of scripts installs and starts CouchDB 1.6.1, Redis, nginx, nodejs, UFW 
and Couchbox over clean Ubuntu. You can a) clone this repo, or 
b) download  install_couchbox_ubuntu.zip into temp folder and unpack it. 
Next, [preconfigure](#preconfigure) installation scripts and [run the sequence](#run).

Scripts will download all dependencies and components, then install and start them.
Also scripts configure autostart. Operations take ~3–5 minutes.

Fast internet connection and at least 2Gb of RAM required (npm is hungry, sorry).

## Preconfigure

Setup params in:

* config.sh 
* nginx.conf
* couchbox.json

## Run

Run install script, typing `sh install.sh` in appropriate folder. After installation
process finished, Couchbox is accessible at https://server:6984
