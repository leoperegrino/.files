{pkgs, lib, config, ...}:
let
  cfg = config.modules.users.tmux;
  afterConfig = "~/.files/config/tmux/tmux.conf";
in {

  options.modules.users = {
    tmux.enable = lib.mkEnableOption "tmux";
  };

  config = lib.mkIf cfg.enable {

    programs.tmux = {
      enable = true;
      prefix = "C-q";
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "screen-256color";
      mouse = true;
      keyMode = "vi";
      clock24 = true;
      historyLimit = 10000;
      escapeTime = 0;
      plugins = [ ];
      extraConfig = "source-file ${afterConfig}";
    };

  };

}
