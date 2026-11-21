{ config, pkgs, inputs, lib, ... }:

{
  home.username = "mkkuu";
  home.homeDirectory = "/home/mkkuu";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  wayland.windowManager.hyprland.settings = {
    exec-once = [
    ];
  };

  systemd.user.services.blueman-applet.serviceConfig.ExecStart = [
    ""  # vide l'ExecStart upstream
    "${pkgs.blueman}/bin/blueman-applet"
  ];

  programs.hyprpanel = {
    enable = true;
  };
}
