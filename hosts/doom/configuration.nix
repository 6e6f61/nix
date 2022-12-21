{ inputs, outputs, config, pkgs, ... }:

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
      alsa.enable = true;
      #alsa.support32Bit = true;
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

  users.users.i = {
    isNormalUser = true;
    packages = with pkgs; [
      firefox tdesktop

      python311 git xorriso qemu tmux
      inputs.zig.packages.x86_64-linux.master

      keepassxc pfetch veracrypt
      ktorrent mullvad-vpn cinny
      feh

      ffmpeg mpv obs-studio

      unzip unrar ark

      prismlauncher

      spotify discord obsidian

      dmenu rxvt-unicode
    ];
  };
  programs.kdeconnect.enable = true;
  programs.steam.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "qt";
  };

  environment.systemPackages = with pkgs; [
    helix git
  ];

  fonts.fontDir.enable = true;
  fonts.fonts = [ outputs.packages.x86_64-linux.monaco-font ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.auto-optimise-store = true;
  system.stateVersion = "22.05";
}

