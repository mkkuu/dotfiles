
import { createState } from "ags";
import { exec } from "ags/process";

// Notification button
const start_state = exec("makoctl mode")
    .split(/\s+/)
    .includes("do-not-disturb");

const [notif, setNotif] = createState(start_state);
const [labelNotif, setLabelNotif] = createState(
    start_state ? "" : ""
);

const toggle_dnd = () => {
    const next = !notif.peek();

    exec("makoctl mode -t do-not-disturb");

    setNotif(next);
    setLabelNotif(next ? "" : "");
};

export default function Distro() {
    return (
        <box>
            <image
                file="./widget/imgs/nixos.png"
                pixel_size={16}
                css_name="distro_label"
            />
            <box>
                <button onClicked={toggle_dnd}>
                    <label
                        label={labelNotif}
                        css_name="notif_label"
                    />
                </button>
            </box>
        </box>
    );
}
