#!/bin/sh
set -e

BASE="$(cd "$(dirname "$0")" && pwd)"

echo "Installing to ~/.local ..."

mkdir -p ~/.local

chmod +x "$BASE/gnome-shell/extensions/vbox-wmclass-hook@local/vbox_update_wmclass.sh
cp -r "$BASE/.local/"* ~/.local/
gnome-extensions enable vbox-wmclass-hook@local
echo "Done."
echo "need logout and relogin"
