#!/bin/bash

SRC="$HOME/.chezmoiinstall/suldr-keyring.gpg"
DST="/etc/apt/trusted.gpg.d"
DSFTILE="$DST/suldr-keyring.gpg"
# sudo gpg -v --dearmor --output "$DST" "$SRC"
sudo mkdir -p "$DST"
sudo install -v -o root -g root -m 644 "$SRC" "$DST/"

echo "Adding custom repository $DSFTILE..."
sudo mkdir -p /etc/apt/sources.list.d
sudo tee -a /etc/apt/sources.list.d/suldr.sources > /dev/null <<EOL
Types: deb
URIs: https://www.bchemnet.com/suldr/
Suites: debian
Components: extra
Signed-By: $DSTFILE
EOL

sudo apt update
sudo apt install -y suld-driver2-1.00.39