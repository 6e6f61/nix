{ inputs, lib, config, pkgs, ... }:

let username = "i";
in
{
  imports = [ ];

  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "noatime";
      userEmail = "";
    };

    bash.enable = true;
    bash.historyControl = [ "ignorespace" ];
    bash.shellAliases = {
      nrs = "doas nixos-rebuild switch --flake /home/${username}/Nix#officewerks";
      hms = "home-manager switch --flake /home/${username}/Nix#${username}@officewerks";
    };
    bash.sessionVariables = {
      path = "$PATH:/home/${username}/.bin/zig/zig";
    };
    bash.shellInit = "unset HISTFILE";
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "22.05";
}
