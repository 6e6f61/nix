{ inputs, lib, config, pkgs, hostConfig, ... }:

let
  username = hostConfig.username;
  hostname = hostConfig.hostname;
in
{
  imports = [ inputs.hardware.nixosModules.framework-12th-gen-intel ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "quiet" "i915.enable_psr=0" ];

    initrd.systemd.enable = true;

    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 5;
    loader.efi.canTouchEfiVariables = true;
    
    plymouth.enable = true;
    plymouth.theme = "breeze";
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ intel-media-driver vaapiIntel ];
  };

  networking.hostName = hostname;
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
    };

    syncthing = {
      enable = true;
      user = username;
      dataDir = "/home/${username}/Sync";
      configDir = "/home/${username}/.config/syncthing";
    };

    mullvad-vpn = {
      enable = true;
      #Doesn't werks
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
    users = [ username ];
    keepEnv = true;
    persist = true;
  }];

  users.users."${username}" = {
    isNormalUser = true;
    packages = with pkgs; [
      # Web
      firefox tdesktop cinny-desktop kmail
      tor-browser-bundle-bin

      # Development
      vscodium python311 git tmux texlive.combined.scheme-full

      # Accessories
      keepassxc pfetch veracrypt
      ktorrent kate mullvad-vpn
      noto-fonts-cjk-sans

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
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [ helix git ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.auto-optimise-store = true;
  system.stateVersion = "22.05";
}

