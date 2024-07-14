{lib, config, pkgs, ... }:
{

	environment = {
		extraInit = ''
			export         XDG_DATA_HOME="''${HOME}/.local/share"
			export        XDG_STATE_HOME="''${HOME}/.local/state"
			export        XDG_CACHE_HOME="''${HOME}/.cache"
			export       XDG_CONFIG_HOME="''${HOME}/.config"
		'';

		etc."zshenv.local".text = ''
			export ZDOTDIR="''${XDG_CONFIG_HOME}/zsh"
		'';

		etc."profile.local".text = let profile = "\${XDG_CONFIG_HOME}/sh/profile"; in ''
			if test -f "${profile}"; then
				source "${profile}"
			fi
		'';

		etc."bashrc.local".text = let bashrc = "\${XDG_CONFIG_HOME}/bash/bashrc"; in ''
			if test -f "${bashrc}"; then
				source "${bashrc}"
			fi
		'';
	};

}
