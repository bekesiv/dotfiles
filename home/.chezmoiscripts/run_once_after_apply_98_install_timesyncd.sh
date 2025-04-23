#!/bin/bash
set -e

sudo apt install systemd-timesyncd
sudo systemctl enable --now systemd-timesyncd
