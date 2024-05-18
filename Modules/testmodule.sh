#!/bin/bash
source $(dirname "$0")/../functions.sh
set -e

PREREQUISITES=("cheese")
PACKAGES=()

installPackages PREREQUISITES[@] PACKAGES[@]
