{
  description = "Configuration.";

  inputs = {
    nixpkgs.url  = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: rec {
    legacyPackages = nixpkgs.lib.genAttrs [ "x86_64-linux" "x86_64-darwin" ] (system:
      import inputs.nixpkgs {
        inherit system;

        config.allowUnfree = true;
        config.permittedInsecurePackages = [
            # What's using this?
            "qtwebkit-5.212.0-alpha4"
        ];
        
      }
    );

    nixosConfigurations = {
      officewerks = nixpkgs.lib.nixosSystem {
        pkgs = legacyPackages.x86_64-linux;
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/officewerks/configuration.nix ];
      };

      doom = nixpkgs.lib.nixosSystem {
        pkgs = legacyPackages.x86_64-linux;
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/doom/configuration.nix ];
      };
    };

    homeConfigurations = {
      "i@officewerks" = home-manager.lib.homeManagerConfiguration {
        pkgs = legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./hosts/officewerks/home.nix ];
      };

      "i@doom" = home-manager.lib.homeManagerConfiguration {
        pkgs = legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home/doom/home.nix ];
      };
    };
  };
}
