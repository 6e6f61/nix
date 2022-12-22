{
  programs.helix.enable = true;
  programs.helix.settings = {
    theme = "i";
    editor = { true-color = true; };
  };
  programs.helix.themes = {
    i = let
      transparent = "none";
      black = "#1d1f21";
      white = "#c5c8c6";
      grey = "#373b41";
      red = "#cc6666";
      green = "#b5bd68";
      orange = "#de935f";
      yellow = "#f0c674";
      blue = "#5f819d";
      purple = "#85678f";
      aqua = "#5e8d87";
      light_blue = "#8abeb7";
    in {
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
}
