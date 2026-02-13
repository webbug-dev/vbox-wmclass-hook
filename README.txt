vbox-vmclass-hook
================

GNOME Shell extension for automatic WM_CLASS correction of VirtualBox VM windows.

Purpose
-------
VirtualBox creates all VM windows with the same WM_CLASS ("VirtualBox Machine").
Because of this, GNOME Dock groups all VMs together and ignores custom icons or
StartupWMClass from .desktop files.

This extension assigns a unique WM_CLASS to each VM window automatically.

Result:
- each VM appears as a separate application in Dock
- custom icons work correctly
- StartupWMClass works
- windows are not grouped together

How it works
------------
1. listens to GNOME signal: window-created
2. waits ~500 ms (title becomes available)
3. checks window title for "Oracle" and "Running"
4. runs vbox_update_wmclass.sh
5. script updates WM_CLASS using xprop

Requirements
------------
- GNOME Shell
- bash
- wmctrl
- xprop

Installation
------------
Run:

    ./install.sh

This copies all project files into:

    ~/.local/

Enable extension:

    gnome-extensions enable vbox-wmclass-hook@local

Restart session (logout/login).

Project structure
-----------------
.local/gnome-shell/extensions/vbox-wmclass-hook@local
    extension source code

.local/applications
    example .desktop launchers for individual virtual machines

.local/icons
    icons for virtual machines

The applications and icons directories are included intentionally and provide
ready-to-use templates for per-VM launchers and Dock icons.

License
-------
MIT
