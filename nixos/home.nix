{ config, pkgs, inputs, lib, ... }:

{
  home.username = "mkkuu";
  home.homeDirectory = "/home/mkkuu";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  services.wayle = {
    enable = true;
    autoInstallDependencies = true;

    package = pkgs.wayle.overrideAttrs (old: {
      buildInputs = (old.buildInputs or []) ++ [ pkgs.sqlite ];
    });

    settings = {
      styling = {
        theme-provider = "wayle";
      };

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
