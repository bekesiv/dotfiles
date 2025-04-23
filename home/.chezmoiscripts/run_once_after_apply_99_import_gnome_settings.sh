#!/bin/bash
set -e

#Gnome settings
dconf load / < "$HOME/.chezmoiinstall/dconf_settings_dump.dconf"
