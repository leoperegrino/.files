{lib, config, pkgs, ... }:
{
	nix.settings.use-xdg-base-directories = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nix.gc.options = "--delete-older-than 7d";
	nix.gc.automatic = true;

	hardware = {
		enableRedistributableFirmware = true;
		raspberry-pi."4".apply-overlays-dtmerge.enable = true;
		deviceTree = {
			enable = true;
			filter = "*rpi-4-*.dtb";
		};
	};
	console.enable = false;
	boot = {
		kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
		initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
		loader = {
			grub.enable = false;
			generic-extlinux-compatible.enable = true;
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

	networking.networkmanager.enable = true;
	networking.hostName = "raspberrypi";

	services.openssh.enable = true;
	services.openssh.settings.PasswordAuthentication = false;

	users.users."pi" = {
		openssh.authorizedKeys.keys = [
			"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDDLq9FuqWxhgoUARBIkHIDR31zay4kSo59m/p2gjX3yFSEuonW9Dh9FkYThBRBJvoadXmAB7TYLP+6Ma6R2BLR6wr7Q05L79OFBmJLztgE6KD/BHdCwJJE/gxvVJzk7OiLT7xKnQHASSkfvgZt/krvnByNREbd30KKJsWD191JdSZhWclkMA34/kCqd2BhItxLeb3BNq6cgfJdxx+fYg9p/0PkW14xYaRughNHv+v5wh4s/dWTNhh06quwiu5oaS74MP2osJJAU0yN3ddXqBguW8fklMN5WRxy7m3pnsUCDAT6MDH/+fhdTCk75tkYdlVfV6yaKrkP5dnHZpyuHiyolaDGPTKbnLW9gnE/OVgBJelGsEeP+GDkbd16v8rDyiTYDKEgpdP5pRNBd+PBmltYHMfP/Ck3sOdzE9ZB4rwExew3dWl4n/gGzveo8ZuTcf3nXRSZddAiBuxz3wENzsQEPLtyfCmv+ONc6nrCD57RRzvF05a5scGUe4QqeAzaWmp7FbdXaieudvTQL2xiXMSUwaPx+PXOFnhk7Dr0jpBmirfKMinK+mQKzuxomnKCPKtQublMhmx4922P1xoI9R3FohY2HEbpCROrPcBnWEuHVxrlwOCLAq1/ZtUWuzAIcvtBqGSdbBYl6A+OEvKstQD46WrgrC3BJGLtcfRK1NITJw== ltp@nixos"
			"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCp33NKY9pJxYu1wgV/vemJwAHiWsSfmf3n39y1PU/yQmOHbTmBmogJ0xIp0YbVtdHI3G7qg5XkIUffTOAOVHaifrSeknFK9xzhFFI0idGKcbS1djdXiYhCQjDI3OxXx8G47LP1UpVmF1QWcQRWUvVESUtMAnQ3IwlSNhovAOa/YFRcKCi1C24gPeEzJQCnb4daw+YcrMfv3vieBrhlIZaOOoYDqx8zvUNh+hp5Ys4YvPy+wVEYAl3bzA+NJO60mFv1SzoIUZZkBLTUjpR+VCkI9jljEGe7VZchOW/8RXDaGmE9DRBaOqms6VTms2ePmlqDIGCgeYw1nWxsc9XV+tH3TVrfaQ//ACYE3PzRo0uwFW2dI5Ph6scffKoQ2BbAhZbs/KYvlQt+ru6P8P1bKiUMxUAzX5jzgo9ammue8BtTsRJ2Vb1v/I2d155njfKv/oNwS++47FJ9gKpvZuyRtrDzSCYPxWuclLliR3b4+5nyMKkVMMfpjn5mCV1bVGHKvY0= u0_a129@localhost"
		];
		isNormalUser = true;
		shell = pkgs.zsh;
		extraGroups = [
			"wheel"
			"networkmanager"
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

		ranger

		zig
		gcc

		libraspberrypi
		raspberrypi-eeprom
	];

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It's perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.11"; # Did you read the comment?
}
