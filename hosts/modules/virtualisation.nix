{pkgs, lib, config, ...}:
let
	cfg = config.modules;
in {

	options.modules = {
		docker.enable = lib.mkEnableOption "docker";
		podman.enable = lib.mkEnableOption "podman";
		virtualbox.enable = lib.mkEnableOption "virtualbox";
	};

	config = {

		virtualisation = {
			containers.enable = (cfg.podman.enable || cfg.docker.enable);

			docker.enable = cfg.docker.enable;

			podman = lib.mkIf cfg.podman.enable {
				enable = true;
				extraPackages = [
					pkgs.podman-compose
				];
				defaultNetwork.settings = {
					dns_enabled = true;
				};
			};

			virtualbox = lib.mkIf cfg.virtualbox.enable {
				host.enable = true;
				host.enableExtensionPack = true;
				guest.enable = true;
			};
		};
	};

}
