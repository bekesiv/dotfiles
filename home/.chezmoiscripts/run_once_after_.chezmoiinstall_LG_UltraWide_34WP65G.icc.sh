#!/bin/bash
set -e

COLOR_PROFILE_FILENAME="LG_UltraWide_34WP65G.icc"
COLORD_DIR="/usr/share/color/icc/colord"
DEVICE_OBJECT_PATH=$(colormgr get-devices-by-kind display | awk '/Object Path:/ { print $3 }')

sudo install -v -o root -g root -m 644 "$HOME/.chezmoiinstall/$COLOR_PROFILE_FILENAME" "$COLORD_DIR/"

sudo systemctl restart colord
TIMEOUT=5
while ! colormgr get-devices &> /dev/null; do
    ((TIMEOUT--))
    if [[ $TIMEOUT -le 0 ]]; then
        echo "Timed out waiting for colord to respond via D-Bus ❌"
        exit 1
    fi
    sleep 1
done
echo "colord is active and responding 🟢"

# sudo colormgr import-profile "$COLORD_DIR/$COLOR_PROFILE_FILENAME" 
# sleep 3

PROFILE_OBJECT_PATH=$(colormgr find-profile-by-filename "$COLORD_DIR/$COLOR_PROFILE_FILENAME" | awk '/Object Path:/ { print $3 }')

sudo colormgr device-add-profile "$DEVICE_OBJECT_PATH" "$PROFILE_OBJECT_PATH"
