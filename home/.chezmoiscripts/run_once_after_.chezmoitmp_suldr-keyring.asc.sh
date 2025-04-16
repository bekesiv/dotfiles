#!/bin/bash

SRC="$HOME/.chezmoitmp/suldr-keyring.asc"
DST="/etc/apt/trusted.gpg.d/suldr-keyring.gpg"
sudo gpg -v --dearmor --output "$DST" "$SRC"

echo "Adding custom repository /etc/apt/sources.list.d/..."
sudo tee -a /etc/apt/sources.list.d/home\:Alexx2000.list > /dev/null <<EOL
# Backport repository
deb https://www.bchemnet.com/suldr/ debian extra
EOL


