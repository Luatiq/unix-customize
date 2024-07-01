#!/bin/bash
set -e

echo "Installing nvm"

if command -v nvm >/dev/null 2>&1; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
else
    echo "nvm was already installed"
fi

set +e
