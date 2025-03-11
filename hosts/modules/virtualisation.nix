{pkgs, lib, config, ...}:
let
  cfg = config.modules.hosts.virtualisation;
in {

  options.modules.hosts = {
    virtualisation.docker.enable = lib.mkEnableOption "docker";
    virtualisation.podman.enable = lib.mkEnableOption "podman";
    virtualisation.virtualbox.enable = lib.mkEnableOption "virtualbox";
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
        host.addNetworkInterface = false;
        host.enableKvm = true;
        guest.enable = true;
        guest.vboxsf = true;
        guest.seamless = false;
        guest.dragAndDrop = false;
        guest.clipboard = true;
      };
    };

  };

}
