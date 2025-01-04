{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
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

    nixosSystem = {system, user, host, modules ? []}:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit user host;};
        modules = [

          ./hosts/${host}

          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                pkgs-unstable = import nixpkgs-unstable {
                  inherit system;
                };
              };
              backupFileExtension = "bak";
              users."${user}".imports = [./users/${user}.nix];
            };
          }

        ] ++ modules;
      };

  in {

    nixosConfigurations = {

      "thinkpad" = nixosSystem {
        system = "x86_64-linux";
        user = "ltp";
        host = "thinkpad";
      };

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
