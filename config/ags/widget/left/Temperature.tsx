
import { createPoll } from "ags/time";

function transform(val: string) {
    if (!val) return " --°C";

    try {
        const sensors = JSON.parse(val);
        const temperature =
            sensors["coretemp-isa-0000"]?.["Package id 0"]?.["temp1_input"];

        if (typeof temperature !== "number") {
            return " --°C";
        }

        return ` ${temperature.toFixed(1)}°C`;
    } catch {
        return " --°C";
    }
}

const temperature = createPoll("", 2000, "sensors -j");

export default function Temperature() {
    return (
        <label
            label={temperature.as(transform)}
            css_name="temperature_label"
        />
    );
}
