{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.modules.users.xdg;

  symlink = config.lib.file.mkOutOfStoreSymlink;
  home = config.home.homeDirectory;
  dotfiles = "${home}/.files/config";
in
{

  options.modules.users = {
    xdg.enable = lib.mkEnableOption "xdg support";
  };

  config = lib.mkIf cfg.enable {

    xdg.userDirs = {
      desktop = "${home}/desktop";
      download = "${home}/downloads";
      documents = "${home}/documents";
      pictures = "${home}/pictures";
      videos = "${home}/videos";
      music = null;
      templates = null;
      publicShare = null;
      enable = true;
      createDirectories = true;
    };

    xdg.configFile = {
      "vim" = {
        source = symlink "${dotfiles}/vim";
        recursive = true;
      };
      "x" = {
        source = symlink "${dotfiles}/x";
        recursive = true;
      };
      "tmux" = {
        source = symlink "${dotfiles}/tmux";
        recursive = true;
      };
      "python" = {
        source = symlink "${dotfiles}/python";
        recursive = true;
      };
    };

    xdg.autostart = {
      enable = true;
      entries = let
        xbindkeysrc = pkgs.writeText "xbindkeysrc" ''
          "xte "key XF86AudioLowerVolume""
          m:0x0 + b:8

          "xte "key XF86AudioRaiseVolume""
          m:0x0 + b:9
        '';
        xbind_sh = pkgs.writeShellScript "xbind.sh" ''
          pkill xbindkeys
          ${pkgs.xbindkeys}/bin/xbindkeys --file ${xbindkeysrc}
        '';
        xbind_desktop = pkgs.makeDesktopItem {
          name = "xbind";
          desktopName = "xbind";
          exec = xbind_sh;
          comment = "Bind mouse buttons to up/down volume";
        };
      in [
        "${xbind_desktop}/share/applications/xbind.desktop"
      ];
    };

    home.sessionVariables = {
      XDG_CACHE_HOME = "${config.xdg.cacheHome}";
      XDG_CONFIG_HOME = "${config.xdg.configHome}";
      XDG_DATA_HOME = "${config.xdg.dataHome}";
      XDG_STATE_HOME = "${config.xdg.stateHome}";
    };

  };
}
