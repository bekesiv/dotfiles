#!/bin/bash

SRC="$HOME/.chezmoiinstall/microsoft.asc"
DST="/etc/apt/trusted.gpg.d/microsoft.gpg"
sudo gpg -v --dearmor --output "$DST" "$SRC"

echo "Adding custom repository $DST..."
sudo tee -a /etc/apt/sources.list.d/vscode.list > /dev/null <<EOL
# Backport repository
deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/repos/code stable main
EOL

sudo apt update
sudo apt install -y code

xargs -n 1 code --force --install-extension < "$CHEZMOI_SOURCE_DIR/files/extensions_vscode.list"
