{lib, config, pkgs, ... }:
let
	cfg = config.modules.hosts.environment;
in {

	options.modules.hosts = {
		environment.enable = lib.mkEnableOption "environment settings";
	};

	config = lib.mkIf cfg.enable {

		environment = {
			extraInit = let profile = "\${XDG_CONFIG_HOME}/sh/profile"; in ''
				export         XDG_DATA_HOME="''${HOME}/.local/share"
				export        XDG_STATE_HOME="''${HOME}/.local/state"
				export        XDG_CACHE_HOME="''${HOME}/.cache"
				export       XDG_CONFIG_HOME="''${HOME}/.config"

				if test -f "${profile}"; then
					source "${profile}"
				fi
			'';

			etc."zshenv.local".text = ''
				export ZDOTDIR="''${XDG_CONFIG_HOME}/zsh"
			'';

			etc."bashrc.local".text = let bashrc = "\${XDG_CONFIG_HOME}/bash/bashrc"; in ''
				if test -f "${bashrc}"; then
					source "${bashrc}"
				fi
			'';
		};
	};

}
