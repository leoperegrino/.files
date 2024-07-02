{lib, config, pkgs, ... }:
{
	imports = [
		./syncthing.nix
		./hardware-configuration.nix
	];

	nix.settings.use-xdg-base-directories = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nix.gc.options = "--delete-older-than 7d";

	boot = {
		consoleLogLevel = 0;
		kernelParams = ["quiet"];
		loader = {
			timeout = 0;
			efi.canTouchEfiVariables = true;
			grub = {
				enable = true;
				device = "nodev";
				efiSupport = true;
				configurationLimit = 10;
				enableCryptodisk = true;
				timeoutStyle = "hidden";
			};
		};
	};

	documentation.nixos.enable = false;

	virtualisation.containers.enable = true;
	virtualisation.podman.enable = true;
	virtualisation.podman.extraPackages = [
		pkgs.podman-compose
	];
	virtualisation.podman.defaultNetwork.settings = {
		dns_enabled = true;
	};
	
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

	hardware.bluetooth = {
		enable = true;
		settings = {
			General = {
				JustWorksRepairing = "always";
			};
		};
	};
	hardware.pulseaudio.enable = true;
	hardware.pulseaudio.package = pkgs.pulseaudioFull;

	networking.networkmanager.enable = true;

	services.xserver = {
		enable = true;
		excludePackages = [ pkgs.xterm ];

		autoRepeatInterval = 50;
		autoRepeatDelay = 300;

		xkb = {
			layout = "br-altgr";
			extraLayouts."br-altgr" = {
				description = "br layout with custom altgr";
				languages   = [ "por" ];
				symbolsFile = ./symbols/br-altgr;
			};
		};
	};

	services.libinput.mouse.naturalScrolling = true;
	services.libinput.touchpad.naturalScrolling = true;

	services.desktopManager.plasma6.enable = true;
	services.displayManager.sddm.enable = true;

	services.printing.enable = true;
	services.avahi = {
		enable = true;
		nssmdns4 = true;
		openFirewall = true;
	};

	environment.plasma6.excludePackages = with pkgs; [
		kdePackages.kate
		kdePackages.konsole
		kdePackages.okular
		kdePackages.elisa
		kdePackages.ark
		kdePackages.khelpcenter
		# kdePackages.gwenview
		# kdePackages.dolphin
	];

	users.users."ltp" = {
		isNormalUser = true;
		shell = pkgs.zsh;
		extraGroups = [
			"audio"
			"wheel"
			"networkmanager"
			"syncthing"
		];
	};

	security.sudo.wheelNeedsPassword = false;

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

	programs.neovim = {
		enable = false;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
	};

	programs.htop = {
		enable = true;
		package = pkgs.htop-vim;
		settings = {
			hide_kernel_threads = true;
			hide_userland_threads = true;
			tree_view = true;
			all_branches_collapsed = true;
			highlight_base_name = true;
			show_program_path = false;
			column_meters_0 = ["AllCPUs" "Memory"];
			column_meters_1 = ["DateTime" "System" "Battery" "Uptime" "Blank" "DiskIO" "NetworkIO"];
		};
	};

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
		if test -f "${bashrc}"; then
			source "${bashrc}"
		fi
	'';

	environment.systemPackages = with pkgs; [
		vim

		tree
		tmux
		git
		python3

		bat
		ripgrep

		dig
		traceroute

		parted

		ranger

		zig
		gcc
	];

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It's perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.11"; # Did you read the comment?
}
