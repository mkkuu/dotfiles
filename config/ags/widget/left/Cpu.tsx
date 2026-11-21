
import { createPoll } from "ags/time";

function transform(val: string) {
    const match = val.match(/Cpu\(s\):\s*([\d.,]+)/);

    if (!match) return "  --%";

    const usage = Number(match[1].replace(",", "."));

    return `  ${usage.toFixed(1)}%`;
}

const cpu = createPoll("", 2000, "top -bn1");

export default function Cpu() {
    return (
        <label
            label={cpu.as(transform)}
            css_name="cpu_label"
        />
    );
}
