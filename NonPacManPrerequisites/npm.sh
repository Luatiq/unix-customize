#!/bin/bash
set -e

echo "Installing npm"

if ! command -v npm &> /dev/null; then
    installNonPacManPrerequisites 'nvm'

    nvm install node --latest-npm
else
    echo "npm was already installed"
fi

set +e
