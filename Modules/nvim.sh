#!/bin/bash
set -e

homeDir=$(eval echo "~$USER")

PREREQUISITES=("gcc", "ripgrep")
PACKAGES=("neovim")

installPackages PREREQUISITES[@] PACKAGES[@]

mkdir -p "${homeDir}/.config/nvim"
git clone https://github.com/Luatiq/nvimrc.git "${homeDir}/.config/nvim"

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# @TODO install prereq: Go, Node, PHP, ccls

set +e
