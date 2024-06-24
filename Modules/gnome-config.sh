#!/bin/bash
set -e

homeDir=$(eval echo "~$USER")

PREREQUISITES=("nautilus")
PACKAGES=()

installPackages PREREQUISITES[@] PACKAGES[@]

echo "alias www='cd ~/Documents/Projects/'" >> ./.profile
echo "alias vrc='cd ~/.config/nvim/ && nvim .'" >> ./.profile

setShortcut "Open home dir" "nautilus --browser ${homeDir}" "<Super>e" 2

set +e
