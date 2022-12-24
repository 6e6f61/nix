{ inputs, outputs, lib, config, pkgs, ... }:

let
  username = "i";
in
{

  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };

  programs = {
    home-manager.enable = true;

    bash.enable = true;
    bash = {
      historyControl = [ "ignorespace" ];
      shellAliases = {
        nrs = "doas nixos-rebuild switch --flake /home/${username}/Nix#doom";
        hms = "home-manager switch --flake /home/${username}/Nix#${username}@doom";
      };
      initExtra = ''
        unset HISTFILE
        SSH_ASKPASS=""
      '';
    };
  };

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "22.05";
}