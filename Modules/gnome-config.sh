#!/bin/bash
set -e

homeDir=$(eval echo "~$USER")

PREREQUISITES=("nautilus")
PACKAGES=()

installPackages PREREQUISITES[@] PACKAGES[@]

echo "alias www='cd ~/Documents/Projects/'" >> ./.profile
echo "alias vrc='cd ~/.config/nvim/ && nvim .'" >> ./.profile
echo "export VISUAL=nvim" >> ./.profile
echo "export EDITOR=nvim" >> ./.profile

setShortcut "Open home dir" "nautilus --browser ${homeDir}" "<Super>e" 2

flatInstall "io.missioncenter.MissionCenter"

PACKAGES_TO_REMOVE=("gnome-system-monitor")
removePackages PACKAGES_TO_REMOVE[@]

set +e
