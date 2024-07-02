{
	description = "NixOS configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager.url = "github:nix-community/home-manager/master";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = {
		self,
		nixpkgs,
		home-manager,
		...
	} @ inputs: {

		nixosConfigurations = {
			"nixos" = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./hosts/nixos
					home-manager.nixosModules.home-manager {
						home-manager = {
							# useGlobalPkgs = true;
							useUserPackages = true;
							users."ltp".imports = [./users/ltp];
						};
					}
				];
			};
		};
	};
}
