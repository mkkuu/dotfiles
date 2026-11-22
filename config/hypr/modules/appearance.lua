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

        resize_on_border = true,
        extend_border_grab_area = 12,

        snap = {
            enabled = true,
            monitor_gap = 10,
            window_gap = 10,
            respect_gaps = false,
        },
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

hl.layer_rule({
  match = { namespace = "vicinae" },
  name = "vicinae-blur",
  blur = true,
  ignore_alpha = 0,
})