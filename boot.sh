#!/bin/bash

show_help() {
    echo "Usage: ./typescript-boilerplate.sh -n [directory]"
    echo "This script sets up a TypeScript project boilerplate in the specified directory."
    echo "Example: ./typescript-boilerplate.sh -n my-project"
    exit 1
}

while getopts "n:h" opt; do
    case $opt in
        n) directory="$OPTARG";; # -n <directory>
        h) show_help;; # -h shows help
        *) show_help;;
    esac
done

if [ -z "$directory" ]; then
    show_help
fi

echo "Creating directory as $directory"

mkdir -p "$directory" && cd "$directory" || exit

echo "Initializing pnpm."

pnpm init

echo "Adding typescript and dependencies."

pnpm add -D typescript @types/node ts-node

echo "Adding tsconfig.json."

pnpm tsc --init
