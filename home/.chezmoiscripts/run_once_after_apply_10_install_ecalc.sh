#!/bin/bash
set -e

# eCalc
github_dir="$HOME/work/github"
if [ ! -d "$github_dir/ecalc" ]; then
    mkdir -p "$github_dir"
    cd "$github_dir"
    git clone git@github.com:bekesiv/ecalc.git
    cd ecalc
    ./make_install.sh   
fi
