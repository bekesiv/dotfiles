#!/bin/bash

SRC="$HOME/.chezmoitmp/home_Alexx2000.asc"
DST="/etc/apt/trusted.gpg.d/home_Alexx2000.gpg"

echo "🔄 Installing DoubleCDM key..."
ls -la ~/.chezmoitmp
echo "Dearmoring GPG Key..."
sudo gpg -v --dearmor "$SRC"
sudo install -v -o root -g root -m 644 "$SRC.gpg" "$DST" || echo "Key downloaded and installed: $DST"
