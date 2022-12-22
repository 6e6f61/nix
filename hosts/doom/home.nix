{ inputs, outputs, lib, config, pkgs, ... }:

let
  username = "i";
  Xresources = {
    read = file: (builtins.readFile (./. + "../../../common" + ("/" + file)));
    dark = (Xresources.read "Xresources.dark");
    urxvt = (Xresources.read "Xresources.urxvt");
  };
in
{
  imports = with outputs.homeManagerModules; [
    herbstluftwm tmux
   ];

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
    bash.initExtra = ''
      unset HISTFILE
      PS1="\[\e[34m\]\w\[\e[m\]\[\e[30m\]%\[\e[m\] "
    '';

    urxvt.enable = true;
    urxvt = {
      scroll.bar.enable = false;
      fonts = [ "xft:Monaco:size=8" ];
    };
  };

  xresources.extraConfig = Xresources.dark + Xresources.urxvt;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "22.05";
}
