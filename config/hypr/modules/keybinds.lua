
local terminal = "kitty"
local browser = "brave"

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + SHIFT + D", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + D", hl.dsp.exec_cmd("vicinae toggle"))

hl.bind("SUPER + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
hl.bind("SUPER + V", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))

hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + M", hl.dsp.exit())

hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("ALT + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + SHIFT + SPACE",hl.dsp.window.float({ action = "toggle" }))

hl.bind("SUPER + SHIFT + Left", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + SHIFT + Right", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + SHIFT + Up", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + SHIFT + Down", hl.dsp.focus({ direction = "d" }))

local workspaces = {
    { key = "A", id = 1 },
    { key = "Z", id = 2 },
    { key = "E", id = 3 },
    { key = "R", id = 4 },
    { key = "T", id = 5 },
}

for _, workspace in ipairs(workspaces) do
    hl.bind(
        "SUPER + " .. workspace.key,
        hl.dsp.focus({ workspace = workspace.id })
    )

    hl.bind(
        "SUPER + SHIFT + " .. workspace.key,
        hl.dsp.window.move({ workspace = workspace.id })
    )
end

hl.bind("SUPER + SPACE", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"),
    { repeating = true, locked = true }
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"),
    { repeating = true, locked = true }
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true }
)
