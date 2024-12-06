{lib, config, pkgs, ... }:
let
  cfg = config.modules.hosts.xserver;
in {

  options.modules.hosts = {
    xserver.enable = lib.mkEnableOption "xserver settings";
  };

  config = lib.mkIf cfg.enable {

    services = {
      xserver = {
        enable = true;
        excludePackages = [ pkgs.xterm ];

        autoRepeatInterval = 50;
        autoRepeatDelay = 300;

        xkb = {
          layout = "br-altgr";
          extraLayouts."br-altgr" = {
            description = "br layout with custom altgr";
            languages   = [ "por" ];
            symbolsFile = ../../config/x/br-altgr;
          };
        };
      };

      libinput.mouse.naturalScrolling = true;
      libinput.touchpad.naturalScrolling = true;

      desktopManager.plasma6 = {
        enable = true;
        enableQt5Integration = false;
      };
      displayManager.sddm.enable = true;
    };

    environment.plasma6.excludePackages = with pkgs; [
      kdePackages.kate
      kdePackages.konsole
      kdePackages.okular
      kdePackages.elisa
      kdePackages.ark
      kdePackages.khelpcenter
      # kdePackages.gwenview
      # kdePackages.dolphin
    ];
  };

}
