#!/bin/bash
set -e

#Gnome settings
dconf load / < "$HOME/.chezmoitmp/dconf_settings_dump.dconf"
