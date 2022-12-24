{
  description = "Configuration.";

  inputs = {
    nixpkgs.url  = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    zig.url = "github:mitchellh/zig-overlay";
    
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, zig, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];

      themes = import ./common/themes;
      configs = import ./common/configurations;
    in
    rec {  
      packages = forAllSystems (system:
         let pkgs = nixpkgs.legacyPackages.${system};
         in import ./pkgs { inherit pkgs; }
       );

      nixosConfigurations = {
        officewerks = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/officewerks/configuration.nix ];
        };

        doom = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/doom/configuration.nix ];
        };
      };

      homeConfigurations = {
        "i@officewerks" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/officewerks/home.nix ];
        };

        "i@doom" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules =
            [
              ./hosts/doom/home.nix
              themes.bluey
              configs.tmux configs.helix configs.herbstluftwm
              configs.git
            ];
        };
      };
    };
}
