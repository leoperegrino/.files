{pkgs, lib, config, ...}:
let
	cfg = config.modules.xdg;

	symlink = config.lib.file.mkOutOfStoreSymlink;
	home = "${config.home.homeDirectory}";
	dotfiles = home + "/.files/config";
in {

	options = {
		modules.xdg.enable = lib.mkEnableOption "enable xdg support";
	};

	config = lib.mkIf cfg.enable {

		xdg.userDirs = {
			desktop = "${home}/desktop";
			download = "${home}/downloads";
			documents = "${home}/documents";
			pictures = "${home}/pictures";
			videos = "${home}/videos";
			music = "${home}/music";
			templates = null;
			publicShare = null;
			enable = true;
			createDirectories = true;
		};

		xdg.configFile = {
			"bash" = {
				source = symlink dotfiles + "/bash";
				recursive = true;
			};
			"nvim" = {
				source = symlink dotfiles + "/nvim";
				recursive = true;
			};
			"sh" = {
				source = symlink dotfiles + "/sh";
				recursive = true;
			};
			"vim" = {
				source = symlink dotfiles + "/vim";
				recursive = true;
			};
			"x" = {
				source = symlink dotfiles + "/x";
				recursive = true;
			};
			"zsh/.zshrc" = {
				source = symlink dotfiles + "/zsh/zshrc";
			};
			"tmux" = {
				source = symlink dotfiles + "/tmux";
				recursive = true;
			};
			"python" = {
				source = symlink dotfiles + "/python";
				recursive = true;
			};
		};

		home.file = {
			".local/state/less/.keep".text = "";
			".local/state/zsh/.keep".text = "";
			".local/share/zsh/.keep".text = "";
			".cache/zsh/.keep".text = "";
			".local/state/bash/.keep".text = "";
		};
	};

}
