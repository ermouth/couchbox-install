# <img align="right" src="https://cdn.cloudwall.me/couchbox/couchbox-github.svg" /> Couchbox install for Ubuntu 20

This set of scripts installs and starts CouchDB, Redis, nginx, nodejs, UFW 
and Couchbox over clean Ubuntu 20. 

You can a) clone this repo, or b) download 
[couchbox-install-master.zip](https://github.com/ermouth/couchbox-install/archive/refs/heads/master.zip) 
into temp folder and unpack it. All stuff is located in `couchbox-install/Ubuntu` folder.

To preconfigure your Couchbox tune `config.sh` script, then if necessary `nginx.conf`, 
and then `couchbox.json`. If you already have some components installed comment them out from 
`install.sh` script, they all are one-liners and easy to locate.

__To run installer type `sudo sh install.sh`.__

Scripts will download all dependencies and components, then install and start them.
Also scripts configure autostarts. Setup takes 5–10 minutes normally, fast internet 
connection and at least 3Gb of RAM required (npm is hungry, sorry).

After install finishes check `http://localhost/index`. It must return `{ text: 'Welcome to Couchbox!' }` 
json which is served by Couchbox-mounted API endpoint from the `couchbox=_design-demo.json` design 
document.

Watch 8 min [YouTube video](https://youtu.be/SzRzMZVN5NU) showing installation process.

## Preconfigure

#### config.sh

Follow comments inside the script.

#### nginx.conf

Re-configure nginx to set up SSL and bind a domain. Set up matching rules for paths 
routed to couchbox.

#### couchbox.json

Set up CORS, emergency notification email address (`couchbox.mail` section), nodename
and plugins config. You can also disable Couchbox logging into CouchDB.

-----------
(c) 2024 ermouth, ftescht. Couchbox and Couchbox-install are MIT licensed.