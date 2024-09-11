{pkgs, lib, config, ...}:
let
	cfg = config.modules.users.alacritty;
in {

	options.modules.users = {
		alacritty.enable = lib.mkEnableOption "alacritty";
	};

	config = lib.mkIf cfg.enable {
		programs.alacritty = {
			enable = true;
			settings = {
				live_config_reload = true;
				scrolling.history = 100000;
				window.padding.x = 0;
				window.padding.y = 0;
				font = {
					size = 12;
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
	};

}
