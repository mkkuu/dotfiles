
import { createState } from "ags";
import { exec } from "ags/process";

// Notification button
let start_state = false;

try {
    start_state = exec("makoctl mode")
        .split(/\s+/)
        .includes("do-not-disturb");
} catch (error) {
    console.error("Unable to retrieve Mako notification mode:", error);
}

const [notif, setNotif] = createState(start_state);
const [labelNotif, setLabelNotif] = createState(
    start_state ? "" : ""
);

const toggle_dnd = () => {
    const next = !notif.peek();

    try {
        exec("makoctl mode -t do-not-disturb");
        setNotif(next);
        setLabelNotif(next ? "" : "");
    } catch (error) {
        console.error("Unable to toggle Mako DND mode:", error);
    }
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
