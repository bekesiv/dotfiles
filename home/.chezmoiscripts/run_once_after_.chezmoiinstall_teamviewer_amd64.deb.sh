#!/bin/bash
set -e

sudo apt install -y libminizip1 policykit-1
sudo dpkg -i $HOME/.chezmoiinstall/teamviewer_amd64.deb
