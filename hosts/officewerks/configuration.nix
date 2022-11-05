{ inputs, lib, config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.hardware.nixosModules.framework-12th-gen-intel
      inputs.home-manager.nixosModules.home-manager
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "quiet" "i915.enable_psr=0" ];
    initrd.systemd.enable = true;
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 5;
    loader.efi.canTouchEfiVariables = true;
    #plymouth.enable = true;
    #plymouth.theme = "breeze";
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
    ];
  };

  networking.hostName = "officewerks";
  networking.networkmanager.enable = true;

  time.timeZone = "Australia/Adelaide";

  services = {
    power-profiles-daemon.enable = false;
    tlp.enable = true;
    fwupd.enable = true;
    fwupd.extraRemotes = [ "lvfs-testing" ];

    xserver = {
      enable = true;
      desktopManager.plasma5.enable = true;
      displayManager.lightdm.enable = true;
    };

    syncthing = {
      enable = true;
      user = "i";
      dataDir = "/home/i/Sync";
      configDir = "/home/i/.config/syncthing";
    };

    mullvad-vpn = {
      enable = true;
      # Doesn't werks
      #package = pkgs.mullvad-vpn;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  security.sudo.enable = false;
  security.doas.enable = true;
  security.doas.extraRules = [{
    users = [ "i" ];
    keepEnv = true;
    persist = true;
  }];

  users.users.i = {
    isNormalUser = true;
    packages = with pkgs; [
      # Web
      firefox tdesktop cinny-desktop fluffychat kmail

      # Development
      vscodium python311 git xorriso qemu tmux kdevelop

      # Accessories
      keepassxc pfetch veracrypt krdc calligra
      ktorrent kate mullvad-vpn

      # Multimedia
      ffmpeg mpv obs-studio

      # Compression
      unzip unrar ark

      # Games
      prismlauncher

      # Unfree
      spotify discord obsidian
    ];
  };
  programs.kdeconnect.enable = true;
  # This clusterfuck of a software comes bundled with a few fixes to work around its clusterfuckedness
  # Also unfree.
  programs.steam.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "qt";
  };

  environment.systemPackages = with pkgs; [
    kakoune
  ];

  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.auto-optimise-store = true;
  system.stateVersion = "22.05";
}

