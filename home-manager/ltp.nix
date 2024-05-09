{
	lib,
	config,
	pkgs,
	...
}: let
	symlink = config.lib.file.mkOutOfStoreSymlink;
	home = "${config.home.homeDirectory}";
	state = "${config.xdg.stateHome}";
	dotfiles = home + "/.files/home-manager/dotfiles";
in {
	imports = [
	];

	home.username = "ltp";
	home.homeDirectory = "/home/ltp";

	xdg.userDirs.desktop = "${home}/desktop";
	xdg.userDirs.download = "${home}/downloads";
	xdg.userDirs.documents = "${home}/documents";
	xdg.userDirs.pictures = "${home}/pictures";
	xdg.userDirs.videos = "${home}/videos";
	xdg.userDirs.music = "${home}/music";
	xdg.userDirs.templates = null;
	xdg.userDirs.publicShare = null;
	xdg.userDirs.enable = true;
	# xdg.userDirs.createDirectories = true;

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
		"ranger" = {
			source = symlink dotfiles + "/ranger";
			recursive = true;
		};
		"tmux" = {
			source = symlink dotfiles + "/tmux";
			recursive = true;
		};
	};

	home.file.".local/state/less/.keep".text = "";
	home.file.".local/state/zsh/.keep".text = "";
	home.file.".local/share/zsh/.keep".text = "";
	home.file.".cache/zsh/.keep".text = "";
	home.file.".local/state/bash/.keep".text = "";

	home.packages = with pkgs; [
		brave
		jellyfin-media-player
		mupdf
		zathura
		keepassxc
		yt-dlp
		nodejs
		unzip
		cargo
		noto-fonts
		noto-fonts-cjk
		noto-fonts-emoji
		(nerdfonts.override { fonts = [ "Noto" ]; })
	];

	programs.home-manager.enable = true;

	programs.git = {
		enable = true;
		extraConfig = {
			blame.date = "format:%Y-%m-%d %H:%M:%S";
			init.defaultBranch = "master";
			log.date = "iso-local";
			pager.status = true;
			pull.rebase = false;
		};
		aliases = {
			b = "branch --list --all";
			ca = "commit --all";
			d = "diff";
			dev = "checkout develop";
			l = "log --graph --all";
			mas = "checkout master";
			master = "checkout master";
			mit = "commit --message";
			out = "checkout";
			p = "pull --all";
			rev-log = "rev-list --pretty --reverse --all --date=format:'%Y-%m-%d %H:%M:%S'";
			s = "status";
			ss = "show --show-signature";
			t = "log --graph --oneline --all";
			undo = "reset HEAD~1";
		};
		# userName = "";
		# userEmail = "";
		# signing = {
		# 	key = "";
		# 	signByDefault = true;
		# };
	};

	programs.alacritty = {
		enable = true;
		settings = {
			live_config_reload = true;
			scrolling.history = 100000;
			window.padding.x = 0;
			window.padding.y = 0;
			font = {
				size = 10;
				normal = {
					family = "NotoSansM Nerd Font";
					style = "Regular";
				};
			};
			keyboard.bindings = [
				{ action = "ScrollLineUp"; key = "K"; mods = "Alt"; }
				{ action = "ScrollLineDown"; key = "J"; mods = "Alt"; }
				{ action = "ScrollHalfPageUp"; key = "K"; mods = "Alt|Shift"; }
				{ action = "ScrollHalfPageDown"; key = "J"; mods = "Alt|Shift"; }
				{ action = "ScrollPageUp"; key = "K"; mods = "Alt|Shift|Control"; }
				{ action = "ScrollPageDown"; key = "J"; mods = "Alt|Shift|Control"; }
			];
		};
	};

	programs.bat = {
		enable = true;
		config = {
			style = "full";
			italic-text = "always";
			paging = "always";
			wrap = "never";
		};
	};

	# programs.ranger = {
	# 	enable = true;
	# 	extraPackages = [
	# 		pkgs.ffmpegthumbnailer
	# 		pkgs.fmt
	# 		pkgs.mpv
	# 		pkgs.mupdf
	# 		pkgs.poppler_utils
	# 		pkgs.python311Packages.pdf2image
	# 		pkgs.w3m
	# 		pkgs.zathura
	# 	];
	# };

	programs.mpv = {
		enable = true;
		bindings = {
			UP = "add volume 2";
			DOWN = "add volume -2";

			"-" = "add sub-scale -0.1";
			"+" = "add sub-scale +0.1";

			"ctrl+=" = "add audio-delay 0.100";

			"ctrl+j" = "cycle sub";
			"ctrl+k" = "cycle sub down";

			J = "add chapter 1";
			K = "add chapter -1";

			l = "seek 2";
			h = "seek -2";
			k = "seek -60";
			j = "seek 60";

			q = "quit-watch-later";
			Q = "quit";

			c = "script-binding console/enable";

			P = "script-message osc-visibility cycle";
			C = "script-message osc-chapterlist 4";
			"'" = "script-binding console/enable";
		};
		config = {
			sub-scale = 0.9;
			sub-pos = 95;
			sid = false;
			osd-bar-align-y = 0.9;
			osd-duration = 2000;
			# window-maximized = yes;
			# geometry = 80%x80%+50%+50%;
			fs = false;
			no-keepaspect-window = "";
			audio-display = "embedded-first";
			volume = 70;
			volume-max = 100;
			script-opts = "ytdl_hook-ytdl_path=${pkgs.yt-dlp}/bin/yt-dlp";
			watch-later-directory = state + "/mpv/watch_later";
			write-filename-in-watch-later-config = true;
		};
	};

	# programs.zsh = {
	# 	enable = true;
	# 	dotDir = ".config/zsh";
	# 	completionInit = "autoload -U compinit && compinit -d ${config.xdg.cacheHome}/zsh/zcompdump-\${ZSH_VERSION}";
	# };

	programs.gpg = {
		enable = true;
		homedir = "${config.xdg.dataHome}/gnupg";
	};

	services.gpg-agent = {
		enable = true;
		defaultCacheTtl = 7200;
		maxCacheTtl = 7200;
		pinentryPackage = pkgs.pinentry-curses;
	};

	systemd.user.startServices = "sd-switch";

	# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
	home.stateVersion = "23.11";
}
