# <img align="right" src="https://cdn.cloudwall.me/couchbox/couchbox-github.svg" /> Couchbox install

This repo contains sets of scripts for installing [Couchbox](https://github.com/ermouth/couchbox) 
and all required dependencies on Ubuntu 20/22. 
The [/Ubuntu](https://github.com/ermouth/couchbox-install/tree/master/Ubuntu) folder
contains full documentation, all configs and installer script.

Script also installs [Photon](https://github.com/ermouth/couch-photon), very convenient 
CouchDB admin panel. Photon is accessible after installation at proxy debug port at 
`http://COUCHBOX_NODE_IP:8888/photon/_design/photon/index.html`.

Installator is intended for fast deployment of new Couchbox nodes so it runs best 
on a clean OS, only `git` must be present to clone installer repo. You can pre-install 
git typing `sudo apt install git -y`.

If you already have some components installed and configured you can comment out 
appropriate installers in `install.sh` script before running it.

-----------
(c) 2024 ermouth, ftescht. Couchbox and Couchbox-install are MIT licensed.