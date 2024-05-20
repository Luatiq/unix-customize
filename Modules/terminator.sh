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

configFileDir=$(eval echo "~$USER")/.config/terminator
configFile=${configFileDir}/config

mkdir -p ${configFileDir}

if [ -f ${configFile} ]; then
    cp ${configFile} ${configFile}.bak
else
    touch ${configFile}
fi

cat $(dirname "$0")/Dotfiles/terminator > ${configFile}

set +e
