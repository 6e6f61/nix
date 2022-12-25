{ inputs, outputs, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "quiet" ];
    initrd.systemd.enable = true;
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 5;
    loader.efi.canTouchEfiVariables = true;
    plymouth.enable = true;
    plymouth.theme = "breeze";
  };

  networking.hostName = "doom";
  networking.networkmanager.enable = true;
  
  time.timeZone = "Australia/Adelaide";

  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  services = {
    xserver = {
      enable = true;
      windowManager.herbstluftwm.enable = true;
      displayManager.sddm.enable = true;
      videoDrivers = [ "nvidia" ];
    };

    syncthing = {
      enable = true;
      user = "i";
      dataDir = "/home/i/Sync";
      configDir = "/home/i/.config/syncthing";
    };

    mullvad-vpn.enable = true;

    pipewire = {
      enable = true;
      # Alsa, Pulseaudio, and Jack emulation/support within Pipewire.
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  security.sudo.enable = false;
  security.doas.enable = true;  
  security.doas.extraRules = [{
    users = ["i"];
    keepEnv = true;
    persist = true;
  }];

  fonts.fontDir.enable = true;
  fonts = {
    fonts = [ outputs.packages.x86_64-linux.monaco-font ];
    fontconfig.defaultFonts = {
      monospace = [ "Monaco" ];
    };
  };

  users.users.i = {
    isNormalUser = true;
    packages = with pkgs; [
      # Web
      firefox tdesktop

      # Programming
      python311 git tmux
      inputs.zig.packages.x86_64-linux.master

      # Terminal
      tmux rxvt-unicode pfetch
      unrar unzip ark ffmpeg

      # Window management
      dmenu lemonbar-xft

      # Media
      flameshot mpv obs-studio feh

      # Assorted
      keepassxc mullvad-vpn

      # Games
      prismlauncher

      # Proprietary software containment
      spotify discord obsidian
    ];
  };

  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    helix git
  ];

  # Sadge
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.auto-optimise-store = true;
  system.stateVersion = "22.05";
}

