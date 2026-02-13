#!/bin/sh
set -e

BASE="$(cd "$(dirname "$0")" && pwd)"
USER_NAME="${SUDO_USER:-$(id -un)}"
HOME_DIR="$(getent passwd "$USER_NAME" | cut -d: -f6)"

echo "Installing to $HOME_DIR/.local ..."

mkdir -p "$HOME_DIR/.local/share/applications" \
         "$HOME_DIR/.local/share/icons" \
         "$HOME_DIR/.local/share/gnome-shell/extensions"

# 1) icons
cp -r "$BASE/icons/"* "$HOME_DIR/.local/share/icons/"

# 2) gnome-shell
cp -r "$BASE/gnome-shell/"* "$HOME_DIR/.local/share/gnome-shell/"

# 3) applications + замена /home/webbug/ -> /home/<user>/
for f in "$BASE/applications/"*.desktop; do
  [ -e "$f" ] || continue
  out="$HOME_DIR/.local/share/applications/$(basename "$f")"
  sed "s|/home/webbug/|$HOME_DIR/|g" "$f" > "$out"
  chmod 0644 "$out"
done

chmod +x "$HOME_DIR/.local/share/gnome-shell/extensions/vbox-wmclass-hook@local/vbox_update_wmclass.sh" || true

gnome-extensions enable vbox-wmclass-hook@local || true
update-desktop-database ~/.local/share/applications

echo "Done."
echo "need logout and relogin"
