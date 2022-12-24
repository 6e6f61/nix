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

    git.enable = true;
    git = {
      userName = "6e6f61";
      userEmail = "";
      extraConfig = {
        init = {
          defaultBranch = "master";
        };
      };
    };

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
#        PS1="\[\e[34m\]\w\[\e[m\]\[\e[30m\]%\[\e[m\] "
    };
  };

  systemd.user.startServices = "sd-switch";
  home.stateVersion = "22.05";
}