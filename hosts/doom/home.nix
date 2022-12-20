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
      userName = "6e6f61";
      userEmail = "";
    };

    bash.enable = true;
    bash.historyControl = [ "ignorespace" ];
    bash.shellAliases = {
      nrs = "doas nixos-rebuild switch --flake /home/${username}/Nix#doom";
      hms = "home-manager switch --flake /home/${username}/Nix#${username}@doom";
    };
    bash.sessionVariables = {
      path = "$PATH:/home/${username}/.bin/zig/zig";
    };
    bash.shellInit = "unset HISTFILE";
  };

  xsession.windowManager.herbstluftwm = {
    extraConfig = "herbstclient detect_monitors";
    keybinds = {
      Mod = "Mod4";
    };
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "22.05";
}
