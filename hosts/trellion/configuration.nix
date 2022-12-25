{ inputs, outputs, pkgs, hostConfig, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "quiet" ];
    initrd.systemd.enable = true;
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 5;
    loader.efi.canTouchEfiVariables = true;
  };

  networking.hostName = hostConfig.hostname;
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts =
    [
      22 # sshd
    ];
  
  time.timeZone = "Australia/Adelaide";

  security.sudo.enable = false;
  security.doas.enable = true;  
  security.doas.extraRules = [{
    users = [hostConfig.username];
    keepEnv = true;
    persist = true;
  }];

  users.users."${hostConfig.username}".isNormalUser = true;

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [ helix git tmux ];

  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.auto-optimise-store = true;
  system.stateVersion = "22.05";
}

