#!/bin/bash

SRC="$HOME/.chezmoitmp/home_Alexx2000.asc"
DST="/etc/apt/trusted.gpg.d/home_Alexx2000.gpg"
sudo gpg -v --dearmor --output "$DST" "$SRC"

echo "Adding custom repository /etc/apt/sources.list.d/..."
sudo tee -a /etc/apt/sources.list.d/home\:Alexx2000.list > /dev/null <<EOL
# Backport repository
deb http://download.opensuse.org/repositories/home:/Alexx2000/Debian_12/ /
EOL

sudo apt update
sudo apt install doublecmd-common doublecmd-gtk doublecmd-plugins
