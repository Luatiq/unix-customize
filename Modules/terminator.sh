#!/bin/bash
set -e

addRepository "ppa:mattrose/terminator"
updateRepos

PREREQUISITES=()
PACKAGES=("terminator")

installPackages PREREQUISITES[@] PACKAGES[@]

hBinDir=$(eval echo "~$USER"/bin)
mkdir -p ${hBinDir}

toggleScriptName=launch_focus_min.sh
toggleScriptLocation=$(dirname "$0")/MiscScripts/${toggleScriptName}

chmod a+x ${toggleScriptLocation}
cp ${toggleScriptLocation} ${hBinDir}

setShortcut "Toggle Terminator" "${hBinDir}/${toggleScriptName} terminator" "F12" 0

set +e
