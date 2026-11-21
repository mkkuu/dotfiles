
import { createPoll } from "ags/time";

function transform(val: string) {
    const line = val.split("\n").find(
        (line) => line.startsWith("Mem:")
    );

    if (!line) return "  -- GiB";

    const values = line.trim().split(/\s+/);
    const used = Number(values[2]);

    if (!Number.isFinite(used)) return "  -- GiB";

    return `  ${(used / 1024 ** 3).toFixed(2)} GiB`;
}

const memory = createPoll("", 2000, "free -b");

export default function Memory() {
    return (
        <label
            label={memory.as(transform)}
            css_name="memory_label"
        />
    );
}
