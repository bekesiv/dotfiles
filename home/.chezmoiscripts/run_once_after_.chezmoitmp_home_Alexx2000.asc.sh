#!/bin/bash

SRC="$HOME/.chezmoitmp/home_Alexx2000.asc"
DST="/etc/apt/trusted.gpg.d/home_Alexx2000.gpg"
sudo gpg -v --dearmor --output "$DST" "$SRC"

