import GLib from 'gi://GLib?version=2.0';
import { Extension } from 'resource:///org/gnome/shell/extensions/extension.js';

export default class VBoxHook extends Extension {
    _id = 0;

    enable() {
        this._id = global.display.connect('window-created', (_d, win) => {
            
            // sleep 0.5
            GLib.timeout_add(GLib.PRIORITY_DEFAULT, 500, () => {
                const t = win.get_title() || '';
                if (t.includes('Oracle') && t.includes('Running')) {
                    GLib.spawn_command_line_async(`/bin/sh -lc ${this.path}/vbox_update_wmclass.sh`);
                    return GLib.SOURCE_REMOVE;
                }
            });
        });
    }

    disable() {
        if (this._id) {
            global.display.disconnect(this._id);
            this._id = 0;
        }
    }
}
