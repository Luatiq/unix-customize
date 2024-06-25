#!/bin/bash
set -e

PREREQUISITES=('wget')
PACKAGES=()

installPackages PREREQUISITES[@] PACKAGES[@]

currDir=$(echo "$PWD")

cd /tmp \
    && wget https://github.com/cheat/cheat/releases/download/4.4.2/cheat-linux-amd64.gz \
    && gunzip cheat-linux-amd64.gz \
    && chmod +x cheat-linux-amd64 \
    && sudo mv cheat-linux-amd64 /usr/local/bin/cheat

cd $currDir

yes | cheat

set +e
