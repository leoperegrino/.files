{lib, config, pkgs, ... }:
{
	imports = [
		# ./syncthing.nix
		# ./hardware-configuration.nix
	];

	nix.settings.use-xdg-base-directories = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nix.gc.options = "--delete-older-than 7d";

	boot.loader.grub.device = "nodev";
	boot.loader.grub.enable = true;
	boot.loader.grub.efiSupport = true;
	boot.loader.efi.canTouchEfiVariables = true;
	# boot.consoleLogLevel = 0;
	# boot.kernelParams = ["quiet"];
	boot.loader.timeout = 5;
	boot.loader.grub.configurationLimit = 10;
	boot.loader.grub.enableCryptodisk = true;
	# boot.loader.grub.timeoutStyle = "hidden";

	virtualisation.podman.enable = true;
	
	time.timeZone = "America/Recife";

	i18n.defaultLocale = "en_US.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ALL = "en_US.UTF-8";
		LC_ADDRESS = "pt_BR.UTF-8";
		LC_MEASUREMENT = "pt_BR.UTF-8";
		LC_MONETARY = "pt_BR.UTF-8";
		LC_NUMERIC = "pt_BR.UTF-8";
		LC_TIME = "pt_BR.UTF-8";
	};

	console.useXkbConfig = true;

	hardware.bluetooth.enable = true;
	hardware.pulseaudio.enable = true;

	networking.networkmanager.enable = true;
	# networking.hostName = "hoxt";

	services.xserver.autoRepeatInterval = 50;
	services.xserver.autoRepeatDelay = 300;

	services.xserver.enable = true;
	services.xserver.xkb.layout = "br-altgr";
	# services.xserver.xkb.variant = "abnt2";
	# services.xserver.xkb.options = "caps:swapescape";
	services.xserver.xkb.extraLayouts."br-altgr" = {
		description = "br layout with custom altgr";
		languages   = [ "por" ];
		symbolsFile = ./symbols/br-altgr;
	};

	services.xserver.libinput.mouse.naturalScrolling = true;
	services.xserver.libinput.touchpad.naturalScrolling = true;

	services.xserver.desktopManager.plasma5.enable = true;
	services.xserver.displayManager.sddm.enable = true;

	environment.plasma5.excludePackages = [
		pkgs.plasma5Packages.okular
		pkgs.plasma5Packages.elisa
		pkgs.plasma5Packages.ark
		pkgs.plasma5Packages.khelpcenter
	];

	users.users."ltp".isNormalUser = true;
	users.users."ltp".shell = pkgs.zsh;
	users.users."ltp".extraGroups = [
		"audio"
		"wheel"
		"networkmanager"
		"syncthing"
	];

	security.sudo.wheelNeedsPassword = false;

	programs.gnupg.agent = {
		enable = true;
		# pinentryFlavor = "curses";
		pinentryPackage = pkgs.pinentry-curses;
	};

	programs.zsh = {
		enable = true;
		histSize = 100000;
		histFile = "\${XDG_STATE_HOME}/zsh/history";

		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;

		interactiveShellInit = ''
			source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
			'';
	};

	programs.neovim.defaultEditor = true;

	system.userActivationScripts.home-setup-nixos.text = ''
		${pkgs.git}/bin/git clone -b kde_plasma --recurse-submodules https://github.com/leoperegrino/.files ~/.files || ${pkgs.git}/bin/git -C ~/.files pull --recurse-submodules
		'';

	# environment.variables
	# environment.shellInit
	# environment.loginShellInit
	# environment.interactiveShellInit
	# environment.shellAliases
	# environment.sessionVariables

	environment.extraInit = ''
		export         XDG_DATA_HOME="''${HOME}/.local/share"
		export        XDG_STATE_HOME="''${HOME}/.local/state"
		export        XDG_CACHE_HOME="''${HOME}/.cache"
		export       XDG_CONFIG_HOME="''${HOME}/.config"
	'';

	environment.etc."zshenv.local".text = ''
		export ZDOTDIR="''${XDG_CONFIG_HOME}/zsh"
	'';

	environment.etc."profile.local".text = let profile = "\${XDG_CONFIG_HOME}/sh/profile"; in ''
		if test -f "${profile}"; then
			source "${profile}"
		fi
	'';

	environment.etc."bashrc.local".text = let bashrc = "\${XDG_CONFIG_HOME}/bash/bashrc"; in ''
		if [ -s "${bashrc}" ]; then
			source "${bashrc}"
		fi
	'';

	environment.systemPackages = with pkgs; [
		htop
		vim
		xclip
		ffmpeg
		bat
		dig
		traceroute
		ripgrep
		parted
		stow
		ranger
		zig
		gcc
		tree
		tmux
		neovim
		python3
		git
		podman-tui
		zsh-autosuggestions
		zsh-syntax-highlighting
		zsh-history-substring-search
	];

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It's perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.11"; # Did you read the comment?
}
