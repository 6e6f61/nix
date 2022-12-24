# nix

Nix configurations for my hosts.

## Hosts

Each host has its own directory in `hosts/`.

- `$host/configuration.nix` and `$host/hardware-configuration.nix` configure NixOS.
- `$host/home.nix` is for system-specific or ad-hoc user Home Manager configuration.

## Common

I'm still not sure how to properly segregate Home Manager configurations.

- `common/themes` is for 'themes'. Themes configure solely the visual aspect of software.
- `common/configurations` configure keybindings and other behaviour of software.

Software managed by modules in `common` are not automatically installed, just configured.

Modules in common are used by adding them to the `modules` declaration in `flake.nix`.

## Packages

Custom packages I want that aren't part of nixpkgs.