#!/usr/bin/env bash

set -euo pipefail

chmod +x install_packages.sh configure_zsh.sh

./install_packages.sh
./configure_zsh.sh

if [ "$SHELL" != "$(which zsh)" ]; then
    sudo chsh -s "$(which zsh)" "$USER"
fi

echo "Run: 'source ~/.zshrc'"
