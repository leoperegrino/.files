{lib, config, ...}:
let
  cfg = config.modules.users.xdg;

  symlink = config.lib.file.mkOutOfStoreSymlink;
  home = config.home.homeDirectory;
  dotfiles = "${home}/.files/config";
in {

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
      "bash" = {
        source = symlink "${dotfiles}/bash";
        recursive = true;
      };
      "sh" = {
        source = symlink "${dotfiles}/sh";
        recursive = true;
      };
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

    home.file = {
      ".local/state/bash/.keep".text = "";
    };
  };

}
