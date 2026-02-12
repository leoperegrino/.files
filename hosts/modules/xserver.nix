{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.hosts.xserver;
in
{
  options.modules.hosts = {
    xserver.enable = lib.mkEnableOption "xserver settings";
  };

  config = lib.mkIf cfg.enable {

    console.useXkbConfig = true;

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
            languages = [ "por" ];
            symbolsFile = ../../config/x/br-altgr;
          };
        };
      };

      libinput = {
        mouse.naturalScrolling = true;
        touchpad.naturalScrolling = true;
      };

      desktopManager.plasma6 = {
        enable = true;
        enableQt5Integration = false;
      };
      displayManager = {
        defaultSession = "plasmax11";
        sddm = {
          enable = true;
          wayland.enable = false;
        };
      };
    };

    fonts.enableDefaultPackages = true;

    programs.kdeconnect.enable = true;

    environment = let k = pkgs.kdePackages; in {
      systemPackages = [
        k.kcalc
        k.kgpg
        k.kmail
        k.kmail-account-wizard
        k.kontact
        k.kcontacts
        k.kwallet
        k.merkuro
        k.okular
        k.ark
      ];
      plasma6.excludePackages = [
        k.kate
        k.konsole
        k.okular
        k.elisa
        k.ark
        k.khelpcenter
        k.discover
        # k.gwenview
        # k.dolphin
      ];
    };
  };

}
