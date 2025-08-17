#!/bin/bash

SRC="$HOME/.chezmoiinstall/microsoft.asc"
DST="/usr/share/keyrings/microsoft.gpg"
sudo gpg -v --dearmor --output "$DST" "$SRC"

echo "Adding custom repository $DST..."
sudo tee /etc/apt/sources.list.d/vscode.sources > /dev/null <<EOL
Types: deb
URIs: https://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: amd64 arm64 armhf
Signed-By: $DST
EOL

sudo apt update
sudo apt install -y code

# xargs -n 1 code --force --install-extension < "$CHEZMOI_SOURCE_DIR/files/extensions_vscode.list"
