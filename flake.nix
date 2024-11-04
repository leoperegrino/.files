{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    ...
  } @ inputs: let
    inherit (self) outputs;

    nixosSystem = {system, user, host, modules ? []}:
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        system = system;
        modules = [
          ./hosts/${host}
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs;};
              backupFileExtension = "bak";
              users."${user}".imports = [./users/${user}.nix];
            };
          }
        ] ++ modules;
      };

  in {

    nixosConfigurations = {

      "nixos" = nixosSystem {
        system = "x86_64-linux";
        user = "ltp";
        host = "nixos";
      };

      "coolermaster" = nixosSystem {
        system = "x86_64-linux";
        user = "cool";
        host = "coolermaster";
      };

      # https://wiki.nixos.org/wiki/NixOS_on_ARM/Raspberry_Pi_4
      # https://blog.janissary.xyz/posts/nixos-install-custom-image
      "raspberrypi" = nixosSystem {
        system = "aarch64-linux";
        user = "pi";
        host = "raspberrypi";
        modules = [nixos-hardware.nixosModules.raspberry-pi-4];
      };

    };
  };
}
