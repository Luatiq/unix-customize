#!/bin/bash
set -e

echo "Installing php"

if ! command -v php &> /dev/null; then
    phpPrereqs=()
    case "${PACMAN}" in
        "yum")
            phpPackages=("php-cli" "php-mysqli" "php-opcache")
            ;;
        "apt-get")
            phpPackages=("php" "libapache2-mod-php" "php-cli" "php-common" "php-xml" "php-mysql" "php-mbstring" "php-intl" "php-readline")
            ;;
        *)
            phpPackages=()
            ;;
    esac

    installPackages phpPackages[@] phpPrereqs[@]

    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    mv 'composer-setup.php' './tmp'

    php ./tmp/composer-setup.php --quiet
    sudo mv ./tmp/composer.phar /usr/local/bin/composer
else
    echo "php was already installed"
fi

set +e
