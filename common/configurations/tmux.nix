{
  programs.tmux = {
    prefix = "C-Space";
    terminal = "screen-256color";
    extraConfig = ''
      set -sg escape-time 0
      set-option -as terminal-features ",xterm-256color:RGB"

      unbind-key -a

      bind : command-prompt
  
      bind v split-window -h
      bind b split-window
      bind c new-window
      
      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R
      bind BSpace last-pane
      bind 0 select-window -t 0
      bind 1 select-window -t 1
      bind 2 select-window -t 2
      bind 3 select-window -t 3
      bind 4 select-window -t 4
      bind 5 select-window -t 5
      bind 6 select-window -t 6
      bind 7 select-window -t 7
      bind 8 select-window -t 8
      bind 9 select-window -t 9

      bind -r Left resize-pane -L 5
      bind -r Down resize-pane -D 5
      bind -r Up resize-pane -U 5
      bind -r Right resize-pane -R 5

      bind r kill-pane
    '';
  };
}
