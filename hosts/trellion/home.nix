{ inputs, outputs, pkgs, hostConfig, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager.users."${hostConfig.username}" = with outputs; {
    imports = [ configs.git configs.tmux configs.helix ];
    
    programs.home-manager.enable = true;

    home = {
      username = hostConfig.username;
      homeDirectory = "/home/${hostConfig.username}";
    };

    programs = {
      bash.enable = true;
      bash = {
        historyControl = [ "ignorespace" ];
        shellAliases = {
          nrs = "doas nixos-rebuild switch --flake /home/${hostConfig.username}/Nix#${hostConfig.hostname}";
        };

        initExtra = ''
          unset HISTFILE
          SSH_ASKPASS=""
        '';
      };
    };

    systemd.user.startServices = "sd-switch";
    home.stateVersion = "22.05";
  };
}