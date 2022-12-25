{ inputs, outputs, config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "quiet" ];
    initrd.systemd.enable = true;
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 5;
    loader.efi.canTouchEfiVariables = true;
  };

  networking.hostName = "trellion";
  networking.networkmanager.enable = true;
  
  time.timeZone = "Australia/Adelaide";

  security.sudo.enable = false;
  security.doas.enable = true;  
  security.doas.extraRules = [{
    users = ["brink"];
    keepEnv = true;
    persist = true;
  }];

  users.users.brink.isNormalUser = true;

  environment.systemPackages = with pkgs; [
    helix git
  ];

  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.auto-optimise-store = true;
  system.stateVersion = "22.05";
}

