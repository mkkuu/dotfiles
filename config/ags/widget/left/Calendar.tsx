
import { createState, createComputed, With, For } from "ags";
import { monitorFile, readFile } from "ags/file";
import GLib from "gi://GLib";
import Gtk from "gi://Gtk";

const DATA = `${GLib.get_user_cache_dir()}/proton-calendar/events.json`;

type Event = {
    name: string;
    calendar: string;
    color: string;
    start: string;
    end: string;
    all_day: boolean;
};

type CalendarData = {
    current: Event | null;
    upcoming: Event[];
    generated_at?: string;
};

function readData(): CalendarData {
    try {
        return JSON.parse(readFile(DATA));
    } catch {
        return { current: null, upcoming: [] };
    }
}

const [data, setData] = createState(readData());
const current = createComputed(() => data().current);
const upcoming = createComputed(() => data().upcoming.slice(0, 6));
const hasUpcoming = data.as(value => value.upcoming.length > 0);

try {
    monitorFile(DATA, () => setData(readData()));
} catch {
    // Synchronisation pas encore disponible.
}

function formatTime(value: string): string {
    return new Date(value).toLocaleTimeString("fr-FR", {
        hour: "2-digit",
        minute: "2-digit",
    });
}

function formatDate(value: string): string {
    const date = new Date(value);

    return date.toLocaleDateString("fr-FR", {
        weekday: "short",
        day: "numeric",
        month: "short",
    });
}

function countdown(value: string): string {
    const minutes = Math.max(
        0,
        Math.round((new Date(value).getTime() - Date.now()) / 60000),
    );

    if (minutes < 60) return `Dans ${minutes} min`;

    const hours = Math.floor(minutes / 60);
    const remainder = minutes % 60;

    return remainder
        ? `Dans ${hours} h ${remainder} min`
        : `Dans ${hours} h`;
}

function EventLine({
    event,
    current = false,
}: {
    event: Event;
    current?: boolean;
}) {
    return (
        <box spacing={10} css_name="event_line">
            <box
                widthRequest={4}
                heightRequest={42}
                css={`background-color: ${event.color}; border-radius: 4px;`}
            />

            <box
                orientation={Gtk.Orientation.VERTICAL}
                hexpand
                spacing={3}
            >
                <label
                    label={event.name}
                    xalign={0}
                    css_name="event_name"
                    ellipsize={3}
                />

                <label
                    label={
                        event.all_day
                            ? "Toute la journée"
                            : `${formatTime(event.start)} – ${formatTime(event.end)}`
                    }
                    xalign={0}
                    css_name="event_details"
                />

                <label
                    label={event.calendar}
                    xalign={0}
                    css_name="event_calendar"
                />
            </box>

            {!current && (
                <box
                    orientation={Gtk.Orientation.VERTICAL}
                    valign={Gtk.Align.CENTER}
                    spacing={3}
                >
                    <label
                        label={countdown(event.start)}
                        css_name="event_countdown"
                    />
                    <label
                        label={formatDate(event.start)}
                        css_name="event_details"
                    />
                </box>
            )}
        </box>
    );
}

export default function Calendar() {
    return (
        <menubutton
            $={(self) => {
                const popover = self.get_popover();
                print("Calendar popover:", popover);
            }}
        >
            <box spacing={8} css_name="calendar_button">
                <label label="󰃭" />
                <label
                    label={data.as((value) =>
                        value.current
                            ? value.current.name
                            : value.upcoming[0]?.name ?? "Aucun événement"
                    )}
                    ellipsize={3}
                />
            </box>

            <popover>
                <box
                    orientation={Gtk.Orientation.VERTICAL}
                    spacing={12}
                    css_name="date_popup"
                >
                    <box
                        orientation={Gtk.Orientation.VERTICAL}
                        spacing={3}
                    >
                        <label label="AGENDA" xalign={0} css_name="agenda_title" />
                        <label
                            label={new Date().toLocaleDateString("fr-FR", {
                                weekday: "long",
                                day: "numeric",
                                month: "long",
                            })}
                            xalign={0}
                            css_name="agenda_date"
                        />
                    </box>

                    <box
                        orientation={Gtk.Orientation.VERTICAL}
                        spacing={8}
                    >
                        <label label="EN COURS" xalign={0} css_name="section_title" />

                        <With value={current}>
                            {(event) => event
                                ? <EventLine event={event} current />
                                : (
                                    <label
                                        label="Aucun événement en cours"
                                        xalign={0}
                                        css_name="noevent"
                                    />
                                )
                            }
                        </With>
                    </box>

                    <box
                        orientation={Gtk.Orientation.VERTICAL}
                        spacing={8}
                    >
                        <box
                            orientation={Gtk.Orientation.VERTICAL}
                            spacing={8}
                        >
                            <label
                                label="À VENIR"
                                xalign={0}
                                css_name="section_title"
                            />

                            <box
                                orientation={Gtk.Orientation.VERTICAL}
                                spacing={12}
                            >

                                <With value={upcoming}>
                                    {(events) =>
                                        events.length === 0 ? (
                                            <label
                                                label="Aucun événement prévu"
                                                xalign={0}
                                                css_name="noevent"
                                            />
                                        ) : (
                                            <box
                                                orientation={Gtk.Orientation.VERTICAL}
                                                spacing={12}
                                            >
                                                <For each={upcoming}>
                                                    {(event) => <EventLine event={event} />}
                                                </For>
                                            </box>
                                        )
                                    }
                                </With>
                            </box>
                        </box>
                    </box>

                    <label
                        label={data.as((value) =>
                            value.generated_at
                                ? `Synchronisé à ${formatTime(value.generated_at)}`
                                : "En attente de synchronisation"
                        )}
                        css_name="sync_label"
                        xalign={0}
                    />
                </box>
            </popover>
        </menubutton>
    );
}
