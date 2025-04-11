#!/bin/bash

set -e

locale_dir="/usr/share/i18n/locales"
SRC="$locale_dir/hu_HU"
DST="$locale_dir/hu_HU_custom"
PATCH="$CHEZMOI_SOURCE_DIR/files/locale-fix.sed"

if [ ! -f "$DST" ]; then
  echo "Generating $DST from $SRC..."
  sed -f "$PATCH" "$SRC" | sudo tee "$DST" > /dev/null
  sudo localedef -i hu_HU_custom -f UTF-8 hu_HU.UTF-8@custom
  echo "Custom locale changed to $DST"
else
  echo "$DST already exists, skipping."
fi
