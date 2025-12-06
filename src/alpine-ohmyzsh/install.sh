#!/bin/sh

set -e

echo "Activating feature 'alpine-zsh'"

apk --no-cache add git zsh

if [ -z "$PLUGINS" ]; then
  PLUGINS=$DEFAULTPLUGINS
else
  PLUGINS="$DEFAULTPLUGINS $PLUGINS"
fi

if [ -z "$_CONTAINER_USER_HOME" ]; then
  if [ -z "$_CONTAINER_USER" ]; then
    _CONTAINER_USER_HOME=/root
  else
    _CONTAINER_USER_HOME=$(getent passwd $_CONTAINER_USER | cut -d: -f6)
  fi
fi

su -c "wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh -s" $_CONTAINER_USER

if command -v starship > /dev/null; then
  echo $'\neval "$(starship init zsh)"' >> $_CONTAINER_USER_HOME/.zshrc
fi

sed -i "s|:/bin/ash|:/bin/zsh|g" /etc/passwd
sed -i "s|:/bin/sh|:/bin/zsh|g" /etc/passwd

echo 'Done!'