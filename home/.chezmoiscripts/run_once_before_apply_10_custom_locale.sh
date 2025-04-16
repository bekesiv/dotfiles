#!/bin/bash

set -e

LOCALE_DIR="/usr/share/i18n/locales"
PATCH="$CHEZMOI_SOURCE_DIR/files/locale-fix.sed"
SRC="$LOCALE_DIR/hu_HU"
DST="$LOCALE_DIR/hu_HU_custom"

if [ ! -f "$DST" ]; then
  echo "Generating $DST from $SRC..."
  sed -E -e 's/(decimal_point[[:space:]]+\"),\"/\1.\"/g' \
         -e 's/(thousands_sep[[:space:]]+\").\"/\1 \"/g' \
         "$SRC" | sudo tee "$DST" > /dev/null
  sudo localedef -i hu_HU_custom -f UTF-8 hu_HU.UTF-8@custom
  echo "Custom locale changed to $DST"
else
  echo "$DST already exists, skipping."
fi
