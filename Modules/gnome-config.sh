#!/bin/bash
set -e

homeDir=$(eval echo "~$USER")

PREREQUISITES=("nautilus")
PACKAGES=()

installPackages PREREQUISITES[@] PACKAGES[@]

setShortcut "Open home dir" "nautilus --browser ${homeDir}" "<Super>e" 2

set +e
