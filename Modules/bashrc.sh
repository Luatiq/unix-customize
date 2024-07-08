#!/bin/bash
set -e

mkdir -p ~/Documents/Projects

echo "alias www='cd ~/Documents/Projects/'" >> ./.profile
echo "alias vrc='cd ~/.config/nvim/ && nvim .'" >> ./.profile
echo "export VISUAL=nvim" >> ./.profile
echo "export EDITOR=nvim" >> ./.profile

set +e
