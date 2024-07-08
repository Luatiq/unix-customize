#!/bin/bash
set -e

echo "Installing mysql"

if ! command -v mysql &> /dev/null; then
    PACKAGES=("mysql-server")

    installPackages PACKAGES[@]

    sudo systemctl enable mysqld
    sudo systemctl start mysqld

    # @TODO https://github.com/shellspec/shellspec/issues/312 ?
    echo "CREATE USER 'app'@'localhost' IDENTIFIED BY '\!ChangeMe\!';" | mysql -u root
    echo "GRANT ALL PRIVILEGES ON \*.\* TO 'app'\@'localhost';" | mysql -u root
else
    echo "mysql was already installed"
fi

set +e
