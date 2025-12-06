#!/bin/sh

set -e

echo "Activating feature 'alpine-starship'"

apk --no-cache add starship

starship preset bracketed-segments -o ~/.config/starship.toml

echo 'Done!'