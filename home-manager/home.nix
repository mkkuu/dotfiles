
{ config, pkgs, inputs, lib, ... }:

{
  home.username = "mkkuu";
  home.homeDirectory = "/home/mkkuu";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  imports = [
    inputs.ags.homeManagerModules.default
  ];

  home.packages = [
    pkgs.brightnessctl
    pkgs.hyprsunset

    (pkgs.python3.withPackages (ps: [
      ps.icalendar
      ps.recurring-ical-events
    ]))
  ];

  programs.ags = {
    enable = true;
    configDir = ../config/ags;

    extraPackages = [
      inputs.astal.packages.${pkgs.system}.battery
      inputs.astal.packages.${pkgs.system}.hyprland
      inputs.astal.packages.${pkgs.system}.wireplumber
      inputs.astal.packages.${pkgs.system}.network

      pkgs.cava
      pkgs.brightnessctl
      pkgs.hyprsunset
      pkgs.libadwaita
      pkgs.libsoup_3
      pkgs.lm_sensors
      
    ];
  };

  services.wayle = {
    enable = true;
    autoInstallDependencies = true;

    package = pkgs.wayle.overrideAttrs (old: {
      buildInputs = (old.buildInputs or []) ++ [ pkgs.sqlite ];
      
    });

    settings = {
      styling.theme-provider = "wayle";

      bar = {
        location = "top";
        scale = 1;
        rounding = "sm";

        layout = [
          {
            monitor = "*";
            left = [ "clock" ];
            center = [ "media" ];
            right = [ "battery" ];
          }
        ];
      };
    };
  };
}
