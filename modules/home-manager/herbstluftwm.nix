{
  xsession.windowManager.herbstluftwm = {
    enable = true;

    extraConfig = "herbstclient detect_monitors";
    tags = [ "work" "music" "browser" "social" ];
    keybinds = {
      # Binding this to quit by default is criminal.
      Mod4-Shift-q = "close";
      Mod4-Shift-r = "reload";

      Mod4-h = "focus left";
      Mod4-j = "focus down";
      Mod4-k = "focus up";
      Mod4-l = "focus right";

      Mod4-BackSpace = "cycle_monitor";
      Mod4-Shift-h = "shift left";
      Mod4-Shift-j = "shift down";
      Mod4-Shift-k = "shift up";
      Mod4-Shift-l = "shift right";
      
      Mod4-Return = "spawn urxvt";
      Mod4-d = "spawn dmenu_run";

      Mod4-r = "remove";
      Mod4-s = "floating toggle";
      Mod4-f = "fullscreen toggle";

      Mod4-period = "use_index +1 --skip-visible";
      Mod4-comma =  "use_index -1 --skip-visible"; 
    };

    rules = [
      "focus=on"
    ];

    settings = {
      frame_gap = 15;
    };
  };
}
