#!/bin/bash
set -e

echo "alias www='cd ~/Documents/Projects/'" >> ./.profile
echo "alias vrc='cd ~/.config/nvim/ && nvim .'" >> ./.profile
echo "export VISUAL=nvim" >> ./.profile
echo "export EDITOR=nvim" >> ./.profile

set +e
