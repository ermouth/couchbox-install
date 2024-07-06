# <img align="right" src="https://cdn.cloudwall.me/couchbox/couchbox-github.svg" /> Couchbox install for Ubuntu 20

This set of scripts installs and starts CouchDB, Redis, nginx, nodejs, UFW 
and Couchbox over clean Ubuntu 20. 

You can a) clone this repo, or b) download 
[couchbox-install-master.zip](https://github.com/ermouth/couchbox-install/archive/refs/heads/master.zip) 
into temp folder and unpack it. All stuff is located at `install/Ubuntu`.

Installator requiers `curl` which can be installed using `sudo apt install curl`.

To preconfigure your Couchbox check/edit `config.sh` script, then if necessary `nginx.conf`, 
and then `couchbox.json`. 

To run installator type `sudo sh install.sh`. 

Scripts will download all dependencies and components, then install and start them.
Also scripts will configure all required autostarts. 

Installation takes 5–10 minutes normally. Fast internet connection and at least 
2Gb of RAM required (npm is hungry, sorry).

After install finishes check `http://localhost/index`. It must return `{ text: 'Welcome to Couchbox!' }` 
json.

Watch 8 min [YouTube video](https://youtu.be/SzRzMZVN5NU), showing installation process.

## Preconfigure

#### config.sh

Follow comments inside the script. Uncomment log-related lines to have log in CouchDB 
bucket (may be useful for multinode log aggregation).

#### nginx.conf

Re-configure nginx to set up SSL and bind a domain. Set up matching rules for paths 
routed to couchbox.

#### couchbox.json

Set up CORS, emergency notification email address (`couchbox.mail` section), nodename
and plugins config.

-----------
(c) 2024 ermouth, ftescht. Couchbox and Couchbox-install are MIT licensed.