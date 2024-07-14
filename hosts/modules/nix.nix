{lib, config, pkgs, ... }:
{

	nix = {
		settings = {
			use-xdg-base-directories = false;
			experimental-features = [ "nix-command" "flakes" ];
		};
		gc = {
			options = "--delete-older-than 7d";
			automatic = true;
		};
	};

}
