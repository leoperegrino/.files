{pkgs, lib, config, ...}:
let
	cfg = config.modules.nvim;
in {

	options = {
		modules.nvim.enable = lib.mkEnableOption "enable nvim";
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
