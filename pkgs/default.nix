{ pkgs ? (import ../nixpkgs.nix) { } }: {
  monaco-font = pkgs.callPackage ./monaco-font/default.nix { };
}
