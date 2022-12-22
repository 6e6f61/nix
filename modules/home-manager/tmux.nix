{
  programs.tmux.enable = true;
  programs.tmux = {
    prefix = "C-Space";
    terminal = "screen-256color";
    extraConfig = ''
      set -sg escape-time 0
      set -sg status-bg blue
      set-option -as terminal-features ",xterm-256color:RGB"

      unbind-key -a

      bind : command-prompt
  
      bind v split-window -h
      bind b split-window
      
      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R
      bind -r BSpace last-pane

      bind -r Left resize-pane -L 5
      bind -r Down resize-pane -D 5
      bind -r Up resize-pane -U 5
      bind -r Right resize-pane -R 5

      bind r kill-pane
    '';
  };
}
