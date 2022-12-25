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

      mkSystems = hostnames:
        builtins.listToAttrs
          (map(hostConfig@{ hostname, username, ... }: {
            name  = hostname;
            value = nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs outputs hostConfig; };
              modules = [ (./. + "/hosts/${hostname}") ];
            };
          }) hostnames);
    in
    rec {
      packages = forAllSystems (system:
         let pkgs = nixpkgs.legacyPackages.${system};
         in import ./pkgs { inherit pkgs; }
       );

      themes  = import ./common/themes;
      configs = import ./common/configurations;

      nixosConfigurations = mkSystems
        [
          { hostname = "trellion";    username = "brink"; }
          { hostname = "officewerks"; username = "i";     }
          { hostname = "doom";        username = "i";     }
        ];
    };
}
