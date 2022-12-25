{ inputs, outputs, pkgs, username }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager.users."${username}" = with outputs; {
    imports = [ configs.git configs.tmux configs.helix ];
    
    programs.home-manager.enable = true;

    home = {
      username = username;
      homeDirectory = "/home/${username}";
    };

    programs = {
      bash.enable = true;
      bash = {
        historyControl = [ "ignorespace" ];
        shellAliases = {
          nrs = "doas nixos-rebuild switch --flake /home/${username}/Nix#trellion";
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