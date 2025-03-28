{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
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

    nixosSystem = {system, host, modules ? []}: nixpkgs.lib.nixosSystem {
        system = system;
        modules = [ ./hosts/${host} overlay-unstable ] ++ modules;
    };

    homeManagerConfiguration = {system, user}: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."${system}";
        modules = [ ./users/${user}.nix overlay-unstable ];
    };

  in {

    nixosConfigurations = {

      "thinkpad" = nixosSystem {
        system = "x86_64-linux";
        host = "thinkpad";
        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-e14-intel
          { services.throttled.enable = false; }
        ];
      };

      "coolermaster" = nixosSystem {
        system = "x86_64-linux";
        host = "coolermaster";
      };

      "raspberrypi" = nixosSystem {
        # https://wiki.nixos.org/wiki/NixOS_on_ARM/Raspberry_Pi_4
        # https://blog.janissary.xyz/posts/nixos-install-custom-image
        system = "aarch64-linux";
        host = "raspberrypi";
        modules = [ nixos-hardware.nixosModules.raspberry-pi-4 ];
      };

    };

    homeConfigurations = {

      "ltp" = homeManagerConfiguration {
        system = "x86_64-linux";
        user = "ltp";
      };

      "cool" = homeManagerConfiguration {
        system = "x86_64-linux";
        user = "cool";
      };

      "pi" = homeManagerConfiguration {
        system = "aarch64-linux";
        user = "pi";
      };

    };

  };
}
