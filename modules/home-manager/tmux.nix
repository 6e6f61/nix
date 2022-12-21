{
  programs.tmux.enable = true;
  programs.tmux = {
    prefix = "C-Space";
    extraConfig = ''
      set -sg escape-time 0
      set -sg status-bg blue
    '';
  };
}
