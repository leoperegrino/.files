{pkgs, lib, config, ...}:
let
	cfg = config.modules.users.bat;
in {

	options.modules.users = {
		bat.enable = lib.mkEnableOption "bat";
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
