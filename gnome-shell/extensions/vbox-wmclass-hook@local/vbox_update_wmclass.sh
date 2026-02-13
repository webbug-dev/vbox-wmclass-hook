#!/bin/sh
wmctrl -lp | grep Oracle | grep Running | while read -r wid _ _ _ name _; do
  xprop -id "$wid" -f WM_CLASS 8s -set WM_CLASS "vbox_$name"
  echo "$wid -> vbox_$name"
done
