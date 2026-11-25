# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  boot.resumeDevice = "/dev/disk/by-uuid/b0654973-13f2-4539-bdf8-76395edcc7d4";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = false;
  services.displayManager.sddm.wayland.enable = false;
  #services.xserver.displayManager.sddm.enable = true;
  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;

  services.displayManager.sddm.enable = false; # on désactive SDDM

  services.tailscale.enable = true;

  virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;
  users.extraGroups.vboxusers.members = [ "mkkuu" ];

  systemd.user.services.polkit-gnome-authentication-agent = {
    description = "Polkit GNOME Authentication Agent";

    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
    };
  };
  
  services.gnome.gnome-keyring.enable = true;
  services.greetd.enable = true;
  services.greetd.settings = {
    default_session = {
      command = "start-hyprland";
      user = "mkkuu";
    };
  };

  programs.hyprland.enable = true;
  programs.seahorse.enable = true;
  programs.wireshark.enable = true;
  programs.nix-ld.enable = true;
  programs.dconf.enable = true;
  services.rabbitmq.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  environment.variables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  environment.sessionVariables = {
    GTK_THEME = "Adwaita";
  };

  security.pam.services.greetd.enableGnomeKeyring = true;
  #security.pam.services.hyprland.enableGnomeKeyring = true;

  # Configure console keymap
  console.keyMap = "fr";

  systemd.oomd = {
    enable = true;
    enableUserSlices = true;
    enableSystemSlice = true;
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pipewire.wireplumber.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  hardware.bluetooth.settings = {
  General = {
    Enable = "Source,Sink,Media,Socket";
    };
  };

  users.users.mkkuu = {
    isNormalUser = true;
    description = "mkkuu";
    extraGroups = [ "networkmanager" "wheel" "wireshark" "docker" ];
    packages = with pkgs; [
    ];
  };

  nixpkgs.config.allowUnfree = true;
 
  documentation.enable = false;  
  services.upower.enable = true;
  
  environment.systemPackages = with pkgs; [
     neovim
     wget
     eza
     playerctl
     pulseaudio
     networkmanagerapplet
     vicinae
     kitty
     wofi
     awww
     mako
     swaybg
     grim
     slurp
     openssl
     polkit_gnome
     qpdf
     udisks
     cmatrix
     git-filter-repo
     bibata-cursors
     gitFull
     hyprpaper
     hyprlock
     hypridle
     btop
     htop
     cbonsai
     asciiquarium
     gparted
     pipes
     tree
     ghostscript
     stdenv.cc.cc
     zlib
     dbus
     xcftools
     ascii-image-converter
     rabbitmq-server
     fastfetch
     nwg-look
     gcc
     nodejs
     unzip
     uv
     gimp
     wirelesstools	
     adwaita-icon-theme
     maven
     wl-clipboard
     cliphist
     chromedriver
     jdk25
     steam-run
     scenebuilder
     obs-studio
     lazydocker
     bluez
     bluez-tools
     pavucontrol	
     brave
     discord
     obsidian
     git
     github-desktop
     vscode
     python312
     python312Packages.pip
     libgcc
     cacert
  ];

  programs.bash.shellAliases = {
    ls = "eza --icons";
    ll = "eza -lh --icons --group-directories-first --git --time-style=long-iso --width=50";
    la = "eza -la --icons";
    lt = "eza --tree --icons";
    lsd ="eza -lh --icons --group-directories-first | less -R";
  };

  fonts.packages = with pkgs; [
    material-design-icons
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  fonts.fontconfig.defaultFonts = {
    monospace = [ "JetBrainsMono Nerd Font" ];
    sansSerif = [ "JetBrainsMono Nerd Font" ];
    serif = [ "JetBrainsMono Nerd Font" ]; 
  };

  services.dbus.enable = true;

  system.stateVersion = "24.05";
}
