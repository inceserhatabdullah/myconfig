#!/usr/bin/env bash

set -euo pipefail

sudo dnf groupinstall "Development Tools" -y
sudo dnf install epel-release -y
sudo dnf makecache
sudo dnf install -y git zsh btop fzf bat ripgrep util-linux-user podman python3 python3-pip 
pip install --user httpie