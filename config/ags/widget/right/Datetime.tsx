
import { Gtk } from "ags/gtk4";
import { createPoll } from "ags/time";
import GLib from "gi://GLib";

const time = createPoll("", 1000, () => {
    return GLib.DateTime.new_now_local().format("%a, %d %b - %H:%M")!;
});

export default function Datetime() {
    return (
        <menubutton>
            <label label={time} css_name="date_label" />

            <popover>
                <box
                    css_name="date_popup"
                    orientation={Gtk.Orientation.VERTICAL}
                >
                    <box orientation={Gtk.Orientation.VERTICAL} css_name="cal_box">
                        <Gtk.Calendar
                            show_day_names={true}
                            show_heading={true}
                        />
                    </box>
                </box>
            </popover>
        </menubutton>
    );
}
