{pkgs, lib, config, ...}:
let
	cfg = config.modules.users.mpv;
in {

	options.modules.users = {
		mpv.enable = lib.mkEnableOption "mpv";
	};

	config = lib.mkIf cfg.enable {
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
				watch-later-directory = "${config.xdg.stateHome}/mpv/watch_later";
				write-filename-in-watch-later-config = true;
			};
		};
	};

}
