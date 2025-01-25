{lib, config, ... }:
let
  cfg = config.modules.hosts.syncthing;
in {

  options.modules.hosts = {
    syncthing.enable = lib.mkEnableOption "syncthing";
    syncthing.user = lib.mkOption { type = lib.types.str; };
  };

  config = lib.mkIf cfg.enable {

    users.users."${cfg.user}".extraGroups = [ "syncthing" ];

    services.syncthing = {
      enable = true;
      user = cfg.user;
      dataDir = "/home/${cfg.user}/syncthing";
      configDir = "/home/${cfg.user}/syncthing/config";
      systemService = true;
      openDefaultPorts = true;
      settings = {
        devices = {
        };
        folders = {
        };
        options = {
          globalAnnounceEnabled = false;
          urAccepted = -1;
          relaysEnabled = false;
          autoUpgradeIntervalH = 0;
        };
      };
    };
  };
}
