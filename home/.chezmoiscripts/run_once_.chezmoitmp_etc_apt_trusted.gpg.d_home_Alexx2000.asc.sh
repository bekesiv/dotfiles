#!/bin/bash

SRC="$HOME/.chezmoitmp/etc/apt/trusted.gpg.d/home_Alexx2000.asc"
MID="${SRC%.asc}.gpg"
DST="${MID/$HOME\/.chezmoitmp/}"

echo "🔄 Installing DoubleCDM key..."
echo "Dearmoring GPG Key..."
sudo gpg -v --dearmor "$SRC"
sudo install -v -o root -g root -m 644 "$MID" "$DST"
echo "Key downloaded and installed: $DST"
