{pkgs, lib, config, ...}:
let
	cfg = config.ltp.bat;
in {

	options = {
		ltp.bat.enable = lib.mkEnableOption "enable bat";
	};

	config = lib.mkIf cfg.enable {
		programs.bat = {
			enable = true;
			config = {
				style = "full";
				italic-text = "always";
				paging = "always";
				wrap = "never";
			};
		};
	};

}
