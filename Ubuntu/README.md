# Couchbox install for Ubuntu 14+

This set of scripts installs and starts CouchDB 1.6.1, Redis, nginx, nodejs, UFW 
and Couchbox over clean Ubuntu. 

You can a) clone this repo, or 
b) download  [archive.tar](https://gitlab.com/Couchbox/install/repository/archive.tar?ref=master) 
into temp folder and unpack it. All stuff is located at `install/Ubuntu`.

To configure, check/edit `config.sh` script, then if necessary `nginx.conf` and `couchbox.json`.
To run install type `sudo sh install.sh`. 

Scripts will download all dependencies and components, then install and start them.
Also scripts will configure all required autostarts. 

Installation takes 5–10 minutes normally. Fast internet connection and at least 
2Gb of RAM required (npm is hungry, sorry).

After install finishes, check `http://localhost/index`. It must return `{ text: 'Welcome to Couchbox!' }` 
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

## CVE-2017-12635 note

Since Couchbox installs CouchDB 1.6.1, which has serious vulnerability, you may use
[special recipe](http://bit.ly/2mRUt37), patching the hole.


-----------
(c) 2017 ftescht, ermouth. Couchbox is MIT licensed.