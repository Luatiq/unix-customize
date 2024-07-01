#!/bin/bash
set -e

homeDir=$(eval echo "~$USER")

PREREQUISITES=("ripgrep")
PACKAGES=("neovim")

installPackages PREREQUISITES[@] PACKAGES[@]

installNonPacManPrerequisites 'go'
# @TODO install prereq: Node, PHP, ccls

mkdir -p "${homeDir}/.config/nvim"
git clone https://github.com/Luatiq/nvimrc.git "${homeDir}/.config/nvim"

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

set +e
