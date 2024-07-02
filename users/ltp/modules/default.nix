{pkgs, lib, config, ...}:
let
	cfg = config.ltp;
in {

	imports = [
		./mpv.nix
		./alacritty.nix
		./git.nix
		./gpg.nix
		./xdg.nix
		./ranger.nix
		./bat.nix
		./nvim.nix
	];

	options = {
		ltp.enable = lib.mkEnableOption "enable ltp modules";
	};

	config = lib.mkIf cfg.enable {
		home.username = "ltp";
		home.homeDirectory = "/home/ltp";

		ltp.mpv.enable = true;
		ltp.alacritty.enable = true;
		ltp.git.enable = true;
		ltp.gpg.enable = true;
		ltp.xdg.enable = true;
		ltp.ranger.enable = true;
		ltp.bat.enable = true;
		ltp.nvim.enable = true;
	};

}
