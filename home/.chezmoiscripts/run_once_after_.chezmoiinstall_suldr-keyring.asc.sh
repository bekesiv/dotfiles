#!/bin/bash

SRC="$HOME/.chezmoiinstall/suldr-keyring.asc"
DST="/etc/apt/trusted.gpg.d/suldr-keyring.gpg"
sudo gpg -v --dearmor --output "$DST" "$SRC"

echo "Adding custom repository $DST..."
sudo mkdir -p /etc/apt/sources.list.d
sudo tee -a /etc/apt/sources.list.d/suldr.sources > /dev/null <<EOL
Types: deb
URIs: https://www.bchemnet.com/suldr/
Suites: debian
Components: extra
Signed-By: $DST
EOL

sudo apt update
sudo apt install -y suld-driver2-1.00.39