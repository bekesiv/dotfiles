#!/bin/bash

SRC="$HOME/.chezmoitmp/suldr-keyring.asc"
DST="/etc/apt/trusted.gpg.d/suldr-keyring.gpg"
sudo gpg -v --dearmor --output "$DST" "$SRC"
