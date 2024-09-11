{pkgs, lib, config, ...}:
let
	cfg = config.modules.hosts;
in {

	imports = [
		./environment.nix
		./locale.nix
		./nix.nix
		./programs.nix
		./virtualisation.nix
		./xserver.nix
	];

	options.modules.hosts = {
		enable = lib.mkEnableOption "host modules";
	};

	config = lib.mkIf cfg.enable {
		modules.hosts.environment.enable = true;
		modules.hosts.locale.enable = true;
		modules.hosts.nix.enable = true;
		modules.hosts.programs.enable = true;
		modules.hosts.xserver.enable = true;
	};

}
