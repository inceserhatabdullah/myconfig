#!/bin/bash

show_help() {
    echo "Usage: ./setup_git.sh -u <username> -e <email> -s <ssh_key_name>"
    echo "This script sets up Git with the provided username and email."
    exit 1
}

while getopts "u:e:s:h" opt; do
    case $opt in
        u) username="$OPTARG";;
        e) email="$OPTARG";;
        s) ssh_key_name="$OPTARG";;
        h) show_help;;
        *) show_help;;
    esac
done

if [ -z "$username" ] || [ -z "$email" ]; then
    show_help
fi

if [ -z "$ssh_key_name" ]; then
    ssh_key_name="id_ed25519"
    echo "Using default SSH key name: $ssh_key_name"
fi

echo "Setting up Git with username: $username and email: $email"

git config --global user.name "$username"
git config --global user.email "$email"
git config --global init.defaultBranch main

echo "Git setup complete."

if [ ! -f "$HOME/.ssh/$ssh_key_name" ]; then
    ssh-keygen -t ed25519 -C "$email" -f "$HOME/.ssh/$ssh_key_name" -N ""
    echo "SSH key generated: $HOME/.ssh/$ssh_key_name"
else
    echo "SSH key already exists: $HOME/.ssh/$ssh_key_name"
fi

eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/$SSH_KEY_NAME
echo "Your SSH key has been set up and added to the keychain."

pbcopy < "$HOME/.ssh/$ssh_key_name.pub"
echo "Public key copied to clipboard. You can now paste it into your GitHub account."
