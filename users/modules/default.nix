{pkgs, lib, config, ...}:
let
	cfg = config.modules.users;
in {

	imports = [
		./alacritty.nix
		./bat.nix
		./git.nix
		./gpg.nix
		./htop.nix
		./mpv.nix
		./nvim.nix
		./ranger.nix
		./xdg.nix
	];

	options.modules = {
		users.enable = lib.mkEnableOption "user modules";
	};

	config = lib.mkIf cfg.enable {
		modules.users.alacritty.enable = true;
		modules.users.bat.enable = true;
		modules.users.git.enable = true;
		modules.users.gpg.enable = true;
		modules.users.htop.enable = true;
		modules.users.mpv.enable = true;
		modules.users.nvim.enable = true;
		modules.users.ranger.enable = true;
		modules.users.xdg.enable = true;
	};

}
