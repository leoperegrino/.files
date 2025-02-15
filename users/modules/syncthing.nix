{lib, config, ... }:
let
  cfg = config.modules.users.syncthing;
  homeDirectory = config.home.homeDirectory;
in {

  options.modules.users = {
    syncthing.enable = lib.mkEnableOption "syncthing";
  };

  config = lib.mkIf cfg.enable {


    services.syncthing = {
      enable = true;
      extraOptions = [
        "-config=${homeDirectory}/syncthing/config/"
        "-data=${homeDirectory}/syncthing/data/"
      ];
      overrideFolders = true;
      overrideDevices = true;
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
