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
	in {

		nixosConfigurations = {

			"nixos" = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs outputs;};
				system = "x86_64-linux";
				modules = [
					./hosts/nixos
					home-manager.nixosModules.home-manager {
						home-manager = {
							useGlobalPkgs = true;
							useUserPackages = true;
							extraSpecialArgs = {inherit inputs;};
							users."ltp".imports = [./users/ltp.nix];
						};
					}
				];
			};

			# https://wiki.nixos.org/wiki/NixOS_on_ARM/Raspberry_Pi_4
			# https://blog.janissary.xyz/posts/nixos-install-custom-image
			"raspberrypi" = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs outputs;};
				system = "aarch64-linux";
				modules = [
					./hosts/raspberrypi
					nixos-hardware.nixosModules.raspberry-pi-4
					home-manager.nixosModules.home-manager {
						home-manager = {
							useGlobalPkgs = true;
							useUserPackages = true;
							extraSpecialArgs = {inherit inputs;};
							users."pi".imports = [./users/pi.nix];
						};
					}
				];
			};

		};
	};
}
