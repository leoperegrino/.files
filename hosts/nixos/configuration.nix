{lib, config, pkgs, ... }:
{

	imports = [
		../modules/nix.nix
		../modules/xserver.nix
		../modules/environment.nix
	];

	boot = {
		consoleLogLevel = 0;
		kernelParams = ["quiet"];
		binfmt.emulatedSystems = [ "aarch64-linux" ];
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

	services.printing.enable = true;
	services.avahi = {
		enable = true;
		nssmdns4 = true;
		openFirewall = true;
	};

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

	nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
	];

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
		cryptsetup

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
