#!/bin/bash

SRC="$HOME/.chezmoiinstall/suldr-keyring.asc"
DST="/etc/apt/trusted.gpg.d/suldr-keyring.gpg"
sudo gpg -v --dearmor --output "$DST" "$SRC"

echo "Adding custom repository $DST..."
sudo tee -a /etc/apt/sources.list.d/home\:Alexx2000.list > /dev/null <<EOL
# Backport repository
deb https://www.bchemnet.com/suldr/ debian extra
EOL

sudo apt update
sudo apt install -y suld-driver2-1.00.39