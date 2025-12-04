{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixos-hardware,
    nixpkgs-unstable,
    ...
  }: let

    overlay-unstable = {
      nixpkgs.overlays = [
        (final: prev: {
          unstable = nixpkgs-unstable.legacyPackages."${prev.system}";
        })
      ];
    };

    nixosConfigurations = configs: builtins.mapAttrs (host: {system, modules ? []}:
      nixpkgs.lib.nixosSystem {
        system = system;
        modules = [ ./hosts/${host} overlay-unstable ] ++ modules;
      }
    ) configs;

    homeConfigurations = configs: builtins.mapAttrs (user: {system, modules ? []}:
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."${system}";
        modules = [ ./users/${user}.nix overlay-unstable ] ++ modules;
      }
    ) configs;

  in {

    nixosConfigurations = nixosConfigurations {
      "thinkpad" = {
        system = "x86_64-linux";
        modules = [ nixos-hardware.nixosModules.lenovo-thinkpad-e14-intel-gen6 ];
      };

      "coolermaster" = {
        system = "x86_64-linux";
      };

      "raspberrypi" = {
        # https://wiki.nixos.org/wiki/NixOS_on_ARM/Raspberry_Pi_4
        # https://blog.janissary.xyz/posts/nixos-install-custom-image
        system = "aarch64-linux";
        modules = [ nixos-hardware.nixosModules.raspberry-pi-4 ];
      };

    };

    homeConfigurations = homeConfigurations {
      "ltp" = {
        system = "x86_64-linux";
      };

      "cool" = {
        system = "x86_64-linux";
      };

      "pi" = {
        system = "aarch64-linux";
      };

    };

  };
}
