#!/bin/bash
set -e

PREREQUISITES=()
PACKAGES=("flameshot")

installPackages PREREQUISITES[@] PACKAGES[@]

setShortcut "Take screenshot" "flameshot gui" "<Super><shift>s" 1

copyDotFiles "flameshot" "flameshot" "flameshot.ini"
