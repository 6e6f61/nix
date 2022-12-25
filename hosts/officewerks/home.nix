{ configs, outputs, hostConfig, ... }:

{
  imports = [ configs.git configs.tmux configs.helix ];
  #imports = with outputs; [ configs.git configs.tmux configs.helix ];

  programs = {
    bash.enable = true;
    bash = {
      historyControl = [ "ignorespace" ];
      shellAliases   = { nrs = "doas nixos-rebuild switch --flake ~/Nix#${hostConfig.hostname}"; };
      initExtra = "unset HISTFILE";
    };
  };
}
