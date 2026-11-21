
hl.on("hyprland.start", function()
    hl.exec_cmd("swaybg -i /home/mkkuu/Projects/dotfiles/wallpapers/wallpaper_porsche2.jpg --mode fill")
    hl.exec_cmd("kitty")
    hl.exec_cmd("mako")
    hl.exec_cmd("wl-paste --watch cliphist store")
end)