#!/bin/bash
set -e

# Unpack Mouse Cursor
icondir="$HOME/.icons"
mouse_cursor_file="openzone-cursors-1.2.9.tar.xz"

mkdir -p "$icondir"
chezmoi decrypt "$CHEZMOI_SOURCE_DIR/files/encrypted_$mouse_cursor_file.age" -v -o "$icondir/$mouse_cursor_file"

if [ -f "$icondir/$mouse_cursor_file" ]; then
    tar -xvf "$icondir/$mouse_cursor_file" -C "$icondir"
    rm -f "$icondir/$mouse_cursor_file"
    echo "Mouse Cursor Pack $mouse_cursor_file unpacked successfully."
else
    echo "Mouse Cursor Pack $mouse_cursor_file not found. (Probably was not decrypted successfully.)"
fi
