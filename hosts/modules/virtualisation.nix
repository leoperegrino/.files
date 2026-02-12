{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.hosts.virtualisation;
in
{

  options.modules.hosts = {
    virtualisation.docker.enable = lib.mkEnableOption "docker";
    virtualisation.podman.enable = lib.mkEnableOption "podman";
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

      libvirtd = lib.mkIf cfg.virt-manager.enable {
        enable = true;
        qemu = {
          swtpm.enable = true;
          vhostUserPackages = [ pkgs.virtiofsd ];
        };
      };
      spiceUSBRedirection.enable = lib.mkDefault cfg.virt-manager.enable;
    };

    programs.virt-manager.enable = cfg.virt-manager.enable;
    # remember to install drivers in windows and use video QXL
    # virtio-win-guest-tools.exe: https://github.com/virtio-win/virtio-win-pkg-scripts/blob/master/README.md
    # spice-guest-tools: https://www.spice-space.org/download.html
    # services.spice-vdagentd.enable = cfg.virt-manager.enable;  # this is only for guest (?)
    environment.systemPackages = lib.mkIf cfg.virt-manager.enable [
      pkgs.virt-viewer
    ];

  };

}
