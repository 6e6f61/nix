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
    bash.initExtra = "unset HISTFILE";

    urxvt.enable = true;
    urxvt = {
      scroll.bar.enable = false;
      fonts = [ "xft:Monaco:size=10" ];
    };
  };

  xresources.extraConfig = Xresources.dark + Xresources.urxvt;

  # xsession.windowManager.herbstluftwm = {
  #   enable = true;

  #   extraConfig = "herbstclient detect_monitors";
  #   tags = [ "work" "music" "browser" "social" ];
  #   keybinds = {
  #     # Binding this to quit by default is criminal.
  #     Mod4-Shift-q = "close";
  #     Mod4-Shift-r = "reload";

  #     Mod4-h = "focus left";
  #     Mod4-j = "focus down";
  #     Mod4-k = "focus up";
  #     Mod4-l = "focus right";

  #     Mod4-BackSpace = "cycle_monitor";
  #     Mod4-Shift-h = "shift left";
  #     Mod4-Shift-j = "shift down";
  #     Mod4-Shift-k = "shift up";
  #     Mod4-Shift-l = "shift right";
      
  #     Mod4-Return = "spawn urxvt";
  #     Mod4-d = "spawn dmenu_run";
  #   };
  # };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "22.05";
}
