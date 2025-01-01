{lib, config, user, ... }:
let
  cfg = config.modules.hosts.syncthing;
in {

  options.modules.hosts = {
    syncthing.enable = lib.mkEnableOption "syncthing";
  };

  config = lib.mkIf cfg.enable {

    users.users."${user}".extraGroups = [ "syncthing" ];

    services.syncthing = {
      enable = true;
      user = user;
      dataDir = "/home/${user}/syncthing";
      configDir = "/home/${user}/syncthing/config";
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
