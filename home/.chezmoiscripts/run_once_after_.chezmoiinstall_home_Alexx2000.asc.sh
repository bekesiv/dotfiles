#!/bin/bash

SRC="$HOME/.chezmoiinstall/home_Alexx2000.asc"
DST="/etc/apt/trusted.gpg.d/home_Alexx2000.gpg"
sudo gpg -v --dearmor --output "$DST" "$SRC"

echo "Adding custom repository $DST..."
sudo mkdir -p /etc/apt/sources.list.d
sudo tee /etc/apt/sources.list.d/doublecommander.sources > /dev/null <<EOL
Types: deb
URIs: http://download.opensuse.org/repositories/home:/Alexx2000/Debian_13/
Components: main
Signed-By: $DST
EOL

sudo apt update
sudo apt install -y doublecmd-common doublecmd-gtk doublecmd-plugins
