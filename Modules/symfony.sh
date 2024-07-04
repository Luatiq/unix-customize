#!/bin/bash
set -e

PREREQUISITES=("php-xml" "php-mbstring" "php-intl" "php-process")
PACKAGES=()

installNonPacManPrerequisites 'php'
installPackages PREREQUISITES[@] PACKAGES[@]

if ! command -v symfony &> /dev/null; then
    curl -sS https://get.symfony.com/cli/installer | bash
    sudo mv ~/.symfony5/bin/symfony /usr/local/bin/symfony
else
    echo "symfony was already installed"
fi

set +e
