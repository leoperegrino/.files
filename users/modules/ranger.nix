{pkgs, lib, config, ...}:
let
	cfg = config.modules.users.ranger;
in {

	options.modules.users = {
		ranger.enable = lib.mkEnableOption "ranger";
	};

	config = lib.mkIf cfg.enable {
		programs.ranger = {
			package = pkgs.ranger.overrideAttrs (prev: {
				makeWrapperArgs = ["--set BAT_STYLE full"];
				preConfigure = prev.preConfigure + ''
					sed -i -e '/#\s*application\/pdf/,/&& exit\s6/s/#//' ranger/data/scope.sh
					sed -i -e '/#\s*video/,/exit 1/s/#//' ranger/data/scope.sh
				'';
			});
			enable = true;
			extraPackages = [
				pkgs.ueberzugpp
				pkgs.ffmpegthumbnailer
				pkgs.poppler_utils
				pkgs.jq
				pkgs.bat
			];
			extraConfig = "default_linemode devicons";
			plugins = [{
				name = "devicons";
				src = builtins.fetchGit {
					url = "https://github.com/alexanderjeurissen/ranger_devicons.git";
					rev = "a8d626485ca83719e1d8d5e32289cd96a097c861";
				};
			}];
			settings = {
				preview_images_method = "ueberzug";
				use_preview_script  = true;
				preview_images  = true;
				preview_files  = true;
				open_all_images  = true;
				draw_borders  = true;
				hidden_filter  = ''^\.|\.(bak|swp)$|^lost\+found$|^__pycache__$'';
				nested_ranger_warning  = true;
				colorscheme  = "jungle";
			};
			mappings = {
				"gu" = "cd ~/.local/share";
				"gs" = "cd ~/.local/state";
				"gf" = "cd ~/.files";
				"gV" = "cd ~/.files/nvim/lua/user/";
				"gc" = "cd ~/.config";
				"gC" = "cd ~/.cache";
				"gb" = "cd ~/bin";
				"gD" = "cd ~/desktop";
				"gd" = "cd ~/documents";
				"gm" = "cd ~/music";
				"gp" = "cd ~/pictures";
				"gv" = "cd ~/videos";
				"gU" = "cd /usr/share/";
				"gr" = "cd /";
				"gt" = "cd /tmp";
				"g/r" = "shell sudo ranger .";

				"ev" = ''shell "''${EDITOR}" -- %s'';
				"eV" = ''console shell "''${EDITOR}" --%space'';
				"et" = ''shell "''${EDITOR}" -p -- %s'';
				"eT" = ''console shell "''${EDITOR}" -p -- %s%space'';
				"es" = ''shell "''${EDITOR}" -O -- %s'';
				"eS" = ''console shell "''${EDITOR}" -O -- %s%space'';
				"EV" = ''shell sudo "''${EDITOR}" -- %s'';
				"V" = ''shell setsid -f alacritty -e zsh -ic "''${EDITOR} -- %s"'';
				"B" = ''shell setsid -f alacritty -e zsh -ic "''${PAGER} -- %s"'';
				"<c-o>" = "console touch%space";

				"CC" = "get_cumulative_size";
				"md" = "console mkdir%space";
				"cW" = "bulkrename";
				"i" = ''shell "''${PAGER}" -- %f'';
				"v" = "mark_files all=True toggle=True";
				"n" = "tab_new";
				"b" = ''shell setsid -f "''${TERM}"'';
				"f" = "console scout -ftse%space";
				"<c-j>" = "scroll_preview 1";
				"<c-k>" = "scroll_preview -1";
			};
		};
	};

}
