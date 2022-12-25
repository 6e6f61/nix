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

      configs = import ./common/configurations;
      themes  = import ./common/themes;

      mkHosts = hostnames:
        builtins.listToAttrs
          (map(hostConfig@{ hostname, username, ... }: {
            name  = hostname;
            value = nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs outputs configs themes hostConfig; };
              modules = [ (./. + "/hosts/${hostname}") ];
            };
          }) hostnames);
    in
    {
      packages = forAllSystems (system:
         let pkgs = nixpkgs.legacyPackages.${system};
         in import ./pkgs { inherit pkgs; }
       );

      nixosConfigurations = mkHosts
        [
          { hostname = "trellion";    username = "brink"; }
          { hostname = "officewerks"; username = "i";     }
          { hostname = "doom";        username = "i";     }
        ];
    };
}
