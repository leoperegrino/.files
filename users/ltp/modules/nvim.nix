{pkgs, lib, config, ...}:
let
	cfg = config.ltp;
in {

	options = {
		ltp.nvim.enable = lib.mkEnableOption "enable nvim";
	};

	config = lib.mkIf cfg.enable {
		programs.neovim = {
			enable = true;
			extraPackages = with pkgs; [
				lua-language-server
			];
		};
	};

}
