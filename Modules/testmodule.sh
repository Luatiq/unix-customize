#!/bin/bash
source $(dirname "$0")/../functions.sh
set -e

PREREQUISITES=("cheese")
PACKAGES=()

# @TODO permission error
installPackages PREREQUISITES[@] PACKAGES[@]
