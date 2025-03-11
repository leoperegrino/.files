{pkgs, lib, config, ...}:
let
  cfg = config.modules.hosts.virtualisation;
in {

  options.modules.hosts = {
    virtualisation.docker.enable = lib.mkEnableOption "docker";
    virtualisation.podman.enable = lib.mkEnableOption "podman";
    virtualisation.virtualbox.enable = lib.mkEnableOption "virtualbox";
    virtualisation.virt-manager.enable = lib.mkEnableOption "virt-manager";
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

      libvirtd.enable = cfg.virt-manager.enable;
      spiceUSBRedirection.enable = cfg.virt-manager.enable;
    };

    programs.virt-manager.enable = cfg.virt-manager.enable;
    environment.systemPackages = lib.mkIf cfg.virt-manager.enable [ pkgs.virt-viewer ];

  };

}
