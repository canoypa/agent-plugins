#!/bin/sh
# Usage: install.sh [--uninstall]
set -eu

name=never-meaningless-branch-name
event=pre-push

src=$(cd "$(dirname "$0")/../../../git-hooks" && pwd)
# The plugin cache path changes on every update, so ~/.gitconfig points at a copy instead.
dest=${XDG_CONFIG_HOME:-$HOME/.config}/git/hooks/$name

case $#:${1:-} in
  (0:) ;;
  (1:--uninstall)
    git config --global --remove-section "hook.$name" 2>/dev/null || true
    if [ -d "$dest" ]; then
      if command -v trash >/dev/null 2>&1; then trash "$dest"; else rm -r "$dest"; fi
    fi
    echo "removed hook.$name and $dest"
    exit 0
    ;;
  (*)
    echo "usage: install.sh [--uninstall]" >&2
    exit 2
    ;;
esac

mkdir -p "$dest"
cp "$src"/* "$dest"/
chmod +x "$dest"/*

git config --global --replace-all "hook.$name.command" "$dest/$event"
git config --global --replace-all "hook.$name.event" "$event"

if ! git hook list "$event" 2>/dev/null | grep -qx "$name"; then
  echo "error: git $(git --version | cut -d' ' -f3) does not list hook.$name; config-based hooks (hook.<name>.command) are required" >&2
  exit 1
fi
echo "installed $dest/$event as hook.$name ($event)"
