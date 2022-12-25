{ inputs, hostConfig, ... }:

let
  username = hostConfig.username;
in
{
  imports =
    [
      ./configuration.nix
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  home-manager.users."${username}" = {
    imports = [ ./home.nix ];

    # Basic boilerplate we'll probably never need to touch.
    programs.home-manager.enable = true;
    home = { username = username; homeDirectory = "/home/${username}"; };
    systemd.user.startServices = "sd-switch";
    home.stateVersion = "22.05";
  };
}
