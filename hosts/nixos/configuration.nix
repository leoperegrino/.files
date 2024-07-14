{lib, config, pkgs, ... }:
{

	imports = [
		../modules/nix.nix
		../modules/xserver.nix
		../modules/programs.nix
		../modules/locale.nix
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
