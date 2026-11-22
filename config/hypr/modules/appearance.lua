hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 1,

        col = {
            active_border = {
                colors = {
                    "rgba(4a2028ff)",
                    "rgba(8e3b36ff)",
                },
                angle = 45,
            },
            inactive_border = "rgba(595959ff)",
        },

        layout = "dwindle",
    },

    decoration = {
        rounding = 0,

        blur = {
            enabled = true,
            size = 8,
            passes = 1,
            new_optimizations = true,
        },

        shadow = {
            enabled = false,
        },
    },

    animations = {
        enabled = false,
    },
})