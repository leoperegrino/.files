{pkgs, lib, config, ...}:
let
	cfg = config.ltp.ranger;
in {

	options = {
		ltp.ranger.enable = lib.mkEnableOption "enable ranger";
	};

	config = lib.mkIf cfg.enable {
		programs.ranger = {
			enable = true;
			extraPackages = [
			];
		};
	};

}
