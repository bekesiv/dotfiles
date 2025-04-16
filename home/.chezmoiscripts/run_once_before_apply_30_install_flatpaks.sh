#!/bin/bash
set -e

files_dir="$CHEZMOI_SOURCE_DIR/files"

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y $(tr '\n' ' ' < "$files_dir/flatpak.list")
flatpak uninstall --unused

# Flatpak does not respect gtk cursors
flatpak --user override --filesystem=$HOME/.icons/:ro
flatpak --user override --filesystem=/usr/share/icons/:ro        
