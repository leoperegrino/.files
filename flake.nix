{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixos-hardware,
    ...
  }: let
    nixosSystem = nixpkgs.lib.nixosSystem;
    homeConfiguration = home-manager.lib.homeManagerConfiguration;
  in {

    nixosConfigurations = {

      "thinkpad" = nixosSystem {
        modules = [
          ./hosts/thinkpad
          nixos-hardware.nixosModules.lenovo-thinkpad-e14-intel-gen6
        ];
      };

      "coolermaster" = nixosSystem {
        modules = [
          ./hosts/coolermaster
        ];
      };

      "raspberrypi" = nixosSystem {
        # https://wiki.nixos.org/wiki/NixOS_on_ARM/Raspberry_Pi_4
        # https://blog.janissary.xyz/posts/nixos-install-custom-image
        modules = [
          ./hosts/raspberrypi
          nixos-hardware.nixosModules.raspberry-pi-4
        ];
      };

    };

    homeConfigurations = {

      "ltp" = homeConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
          ./users/ltp.nix
        ];
      };

      "cool" = homeConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
          ./users/cool.nix
        ];
      };

      "pi" = homeConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-linux";
        modules = [
          ./users/pi.nix
        ];
      };

    };

    nixosModules = {
      hosts = {
        imports = [
          ./hosts/modules/default.nix
        ];
      };
      users = {
        imports = [
          ./users/modules/default.nix
        ];
      };
    };

  };
}
