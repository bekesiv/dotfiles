#!/bin/bash

POLKIT_DIR="/etc/polkit-1/rules.d"
sudo mkdir -p "$POLKIT_DIR"
sudo install -v -o root -g root -m 644 "$HOME/.chezmoiinstall/90-corectrl.rules" "$POLKIT_DIR/90-corectrl.rules"
