{
  xsession.windowManager.herbstluftwm = {
    extraConfig = ''
      herbstclient detect_monitors

      for i in {1..10}
      do
        herbstclient keybind Mod4-''${i} use ''${i}
        herbstclient keybind Mod4-Shift-''${i} move ''${i}
      done
    '';
    tags = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" ];
    keybinds = {
      # Binding this to quit by default is criminal.
      Mod4-Shift-q = "close";
      Mod4-Shift-r = "reload";

      Mod4-h = "focus left --level=tabs";
      Mod4-j = "focus down --level=tabs";
      Mod4-k = "focus up --level=tabs";
      Mod4-l = "focus right --level=tabs";

      # Focus
      Mod4-BackSpace = "cycle_monitor";
      Mod4-period = "use_index +1 --skip-visible";
      Mod4-comma  = "use_index -1 --skip-visible";
      Mod4-Shift-h = "shift left";
      Mod4-Shift-j = "shift down";
      Mod4-Shift-k = "shift up";
      Mod4-Shift-l = "shift right";

      # Applications
      Mod4-Return = "spawn urxvt";
      Mod4-d = "spawn dmenu_run";
      Print = "spawn flameshot gui";

      # Managing Applications
      Mod4-r = "remove";
      Mod4-s = "floating toggle";
      Mod4-f = "fullscreen toggle";
      Mod4-t = "cycle_layout 1 max grid";

      # Splitting
      Mod4-b = "split bottom 0.5";
      Mod4-v = "split right 0.5";
    };

    rules = [ 
      "focus=on"
    ];

    settings = {
      frame_border_active_color = "#8ABEB7";
      frame_border_normal_color = "#00000000";
    };
  };
}
