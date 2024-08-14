{pkgs, lib, config, ...}:
let
	cfg = config.modules.gpg;
in {

	options = {
		modules.gpg.enable = lib.mkEnableOption "enable gpg";
	};

	config = lib.mkIf cfg.enable {

		programs.gpg = {
			enable = true;
			homedir = "${config.xdg.dataHome}/gpg";
		};

		services.gpg-agent = {
			enable = true;
			defaultCacheTtl = 7200;
			maxCacheTtl = 7200;
			pinentryPackage = pkgs.pinentry-curses;
		};
	};

}
