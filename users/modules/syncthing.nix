{lib, config, ... }:
let
  cfg = config.modules.users.syncthing;
in {

  options.modules.users = {
    syncthing.enable = lib.mkEnableOption "syncthing";
  };

  config = lib.mkIf cfg.enable {


    services.syncthing = {
      tray.enable = true;
      enable = true;
      extraOptions = [
        # --config must be ${stateHome}/syncthing for the syncthing-init.service to work
        # https://github.com/nix-community/home-manager/pull/5616#issuecomment-2661610164
        # https://github.com/nix-community/home-manager/blob/1c189f011447810af939a886ba7bee33532bb1f9/modules/services/syncthing.nix#L76
        "--config=${config.xdg.stateHome}/syncthing/"
        "--data=${config.xdg.cacheHome}/syncthing/"
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
