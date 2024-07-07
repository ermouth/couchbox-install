# <img align="right" src="https://cdn.cloudwall.me/couchbox/couchbox-github.svg" /> Couchbox install

This repo contains sets of scripts for installing [Couchbox](https://github.com/ermouth/couchbox) 
and all required dependencies, on Ubuntu. The Ubuntu folder contains full documentation, 
all scripts and also config templates.

Script also installs [Photon](https://github.com/ermouth/couch-photon), very convenient 
CouchDB admin panel. Photon is accessible after installation at proxy debug port at 
`http://COUCHBOX_NODE_IP:8888/photon/_design/photon/index.html`.

Installator is intended for fast deployment of new Couchbox nodes so it runs best 
on a clean OS, out of external utils only `curl` and `git` must be present. You can 
pre-install them typing `sudo apt install curl git -y`.

-----------
(c) 2024 ermouth, ftescht. Couchbox and Couchbox-install are MIT licensed.