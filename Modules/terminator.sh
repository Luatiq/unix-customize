#!/bin/bash
source $(dirname "$0")/../functions.sh
set -e

addRepository "ppa:mattrose/terminator"
updateRepos

PREREQUISITES=()
PACKAGES=("terminator")

installPackages PREREQUISITES[@] PACKAGES[@]

set +e
