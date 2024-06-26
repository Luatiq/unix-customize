#!/bin/bash
set -e

echo "Installing go"

if ! command -v go &> /dev/null; then
    profile=$(eval echo "~$USER")/.profile
    curlFileName="$(curl https://go.dev/VERSION?m=text | head -n 1).linux-amd64.tar.gz"

    curl -OL --output-dir ./tmp "https://go.dev/dl/$curlFileName"
    rm -rf /usr/local/go && tar -C /usr/local -xzf "./tmp/$curlFileName"
    echo 'export PATH=$PATH:/usr/local/go/bin' >> $profile

    # @TODO verify installation
    echo "go has been installed"
else
    echo "go was already installed"
fi

set +e
