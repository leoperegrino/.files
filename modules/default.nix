{pkgs, lib, config, ...}:
let
	cfg = config.modules;
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
		modules.enable = lib.mkEnableOption "enable all modules";
	};

	config = lib.mkIf cfg.enable {
		modules.mpv.enable = true;
		modules.alacritty.enable = true;
		modules.git.enable = true;
		modules.gpg.enable = true;
		modules.xdg.enable = true;
		modules.ranger.enable = true;
		modules.bat.enable = true;
		modules.nvim.enable = true;
	};

}
