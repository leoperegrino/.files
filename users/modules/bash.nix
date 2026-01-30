{
  lib,
  config,
  ...
}:
let
  cfg = config.modules.users.bash;
in
{
  options.modules.users = {
    bash.enable = lib.mkEnableOption "bash";
  };

  config = lib.mkIf cfg.enable {

    programs.bash = {
      enable = true;
      enableCompletion = true;
      historyControl = [
        "erasedups"
        "ignoredups"
        "ignorespace"
      ];
      historyFile = "${config.xdg.stateHome}/bash/history";
      historySize = -1;
      historyFileSize = -1;
      historyIgnore = [
        "ls"
        "cd"
        "q"
        "h"
        "exit"
      ];
      shellOptions = [
        "histappend"
      ];
      shellAliases = {
        h = "history";
      };
      initExtra = /* bash */ ''
        set -o vi
        set -o noclobber
        stty -ixon
        PROMPT_COMMAND="history -a; history -c; history -r"
        OFF="\[\033[0m\]"    # Text Reset
        BR="\[\033[1;31m\]"  # Red
        BG="\[\033[1;32m\]"  # Green
        BC="\[\033[1;36m\]"  # Cyan
        PS1=""
        PS1+="$BC\u$OFF"
        PS1+="@"
        PS1+="$BR\h$OFF"
        PS1+=": "
        PS1+="$BG\w$OFF"
        PS1+=" \$ "
      '';
    };

  };
}
