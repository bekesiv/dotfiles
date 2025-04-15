#!/bin/bash

SRC="$HOME/.chezmoitmp/suldr-keyring.asc"
DST="/etc/apt/trusted.gpg.d/suldr-keyring.gpg"

sudo gpg -v --dearmor "$SRC"
sudo install -v -o root -g root -m 644 "$SRC.gpg" "$DST"
