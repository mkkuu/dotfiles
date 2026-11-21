hl.on("hyprland.start", function()
    hl.exec_cmd("swaybg -i /home/mkkuu/Projects/dotfiles/wallpapers/wallpaper_porsche2.jpg --mode fill")
    hl.exec_cmd("kitty")
    hl.exec_cmd("systemctl --user start mako")
    hl.exec_cmd("wl-paste --watch cliphist store")

    hl.exec_cmd("ags run")

    hl.exec_cmd("hyprsunset")
end)