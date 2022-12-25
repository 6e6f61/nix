{ input, lib, config, pkgs, outputs, ... }:

let
  Xresources = builtins.readFile (./. + "/bluey/Xresources");
  bar_script = ./. + "/bluey/lemonbar.sh";

  transparent = "none";
  black       = "#1d1f21";
  white       = "#c5c8c6";
  grey        = "#373b41";
  red         = "#cc6666";
  green       = "#b5bd68";
  orange      = "#de935f";
  yellow      = "#f0c674";
  blue        = "#5f819d";
  purple      = "#85678f";
  aqua        = "#5e8d87";
  light_blue  = "#8abeb7";
in
{
  xsession.windowManager.herbstluftwm.enable = true;
  xsession.windowManager.herbstluftwm = {
    extraConfig = ''
      herbstclient attr theme.title_when multiple_tabs
      herbstclient attr theme.title_height 15
      herbstclient attr theme.title_color white

      # Maybe there's a more pragmatic way to set the wallpaper, but this werks
      ~/.fehbg

      ${bar_script} | lemonbar &
    '';
    settings = {
      frame_border_active_color = "#8ABEB7";
      frame_border_normal_color = "#00000000";
    };
  };
  
  programs = {
    urxvt.enable = true;
    urxvt.scroll.bar.enable = false;
    urxvt.fonts = [ "xft:Monaco:size=10" ];

    bash.enable = true;
    bash.initExtra = ''
      PS1="\[\e[34m\]\w\[\e[m\]\[\e[30m\]%\[\e[m\] "
    '';

    tmux.enable = true;
    tmux.extraConfig = ''
      set -sg status-bg blue
    '';

    helix.enable = true;
    helix.settings = {
      theme = "i";
      editor = {
        true-color = true;
        cursor-shape = { normal = "bar"; };
      };
    };

    helix.themes.i = {
      "ui.menu" = transparent;
      "ui.menu.selected" = { modifiers = [ "reversed" ]; };
      "ui.linenr" = { fg = white; bg = black; };
      "ui.popup" = { modifiers = [ "reversed" ]; };
      "ui.selection" = { fg = black; bg = light_blue; };
      "ui.selection.primary" = { modifiers = [ "reversed" ]; };
      "ui.statusline.inactive" = { fg = black; bg = aqua; };
      "ui.statusline" = { fg = grey; bg = aqua; };
      "ui.cursor" = { modifiers = [ "reversed" ]; };
      "ui.cursor.match" = { fg = yellow; modifiers = [ "underlined" ]; };
      "ui.virtual.ruler" = { bg = grey; };
      "ui.virtual.whitespace" = { fg = grey; };
      "variable" = light_blue;
      "variable.builtin" = aqua;
      "variable.other.member" = aqua;
      "namespace" = orange;
      "constant" = red;
      "constant.numeric" = purple;
      "type" = green;
      "string" = yellow;
      "function" = red;
      "attributes" = green;
      "diff.plus" = green;
      "diff.delta" = yellow;
      "diff.minus" = red;
      "diagnostic" = { modifiers = [ "underlined" ]; };
      "ui.gutter" = black;
      "info" = light_blue;
      "hint" = grey;
      "debug" = grey;
      "warning" = yellow;
      "error" = red;
      "comment" = { fg = aqua; };
    };
  };

  xresources.extraConfig = Xresources; 
}
