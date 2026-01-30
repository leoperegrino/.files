{
  lib,
  config,
  ...
}:
let
  cfg = config.modules.users.zsh;
in
{
  options.modules.users = {
    zsh.enable = lib.mkEnableOption "zsh";
  };

  config = lib.mkIf cfg.enable {

    programs.zsh = {
      enable = true;
      dotDir = "${config.xdg.configHome}/zsh";

      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;

      completionInit = /* sh */ ''
        zmodload zsh/complist
        autoload -U compinit
        mkdir -p "${config.xdg.cacheHome}/zsh"
        compinit -d "${config.xdg.cacheHome}/zsh/zcompdump-''${ZSH_VERSION}"

        zstyle ':completion:*' file-list all
        zstyle ':completion:*' insert-tab false
        zstyle ':completion:*' menu select
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
        zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS}
        zstyle ':completion:*' group-name ""
        zstyle ':completion:*' format ' %F{yellow}__ %d __%f'

        bindkey -M menuselect '^[[Z' reverse-menu-complete
        bindkey -M menuselect '^P' reverse-menu-complete
        bindkey -M menuselect '^N' expand-or-complete
        bindkey -M menuselect '^E' send-break
        bindkey -M menuselect '^[' send-break
        bindkey -M menuselect '^M' .accept-line
      '';

      initContent = /* sh */ ''
        set -o noclobber
        stty -ixon
        bindkey -v

        bindkey '^?' backward-delete-char

        autoload -U up-line-or-beginning-search
        autoload -U down-line-or-beginning-search
        zle -N up-line-or-beginning-search
        zle -N down-line-or-beginning-search
        bindkey '^P' history-beginning-search-backward
        bindkey '^N' history-beginning-search-forward
        bindkey '^R' history-incremental-search-backward
        bindkey '^S' history-incremental-search-forward
        bindkey -M vicmd 'k' history-beginning-search-backward
        bindkey -M vicmd 'j' history-beginning-search-forward
        bindkey -M vicmd '^V' visual-mode

        autoload -U edit-command-line
        zle -N edit-command-line
        bindkey -M vicmd v edit-command-line

        autoload -U vcs_info
        zstyle ':vcs_info:git:*' formats '%F{yellow}(%b)%f'
        precmd_functions+=( vcs_info )
        zle -N zle-keymap-select
        zle -N zle-line-init
        function zle-line-init zle-keymap-select {
          PROMPT='%B'
          case ''${KEYMAP} in
            vicmd)      echo -ne '\e[1 q';;
            main|viins) echo -ne '\e[5 q';;
            *)          PROMPT+="";;
          esac
          PROMPT+=' %F{red}%n%f'
          PROMPT+='@'
          PROMPT+='%F{blue}%m%f'
          PROMPT+=': '
          PROMPT+='%F{green}%2~%f '
          PROMPT+='%(!.#.$) '
          if git rev-parse --git-dir > /dev/null 2>&1; then
            PROMPT+="\$vcs_info_msg_0_ "
          fi
          PROMPT+='%b'
          zle reset-prompt
        }
      '';

      shellAliases = {
        h = "history 1";
      };

      history = {
        append = true;
        expireDuplicatesFirst = true;
        extended = true;
        findNoDups = true;
        ignoreAllDups = false;
        ignoreDups = true;
        ignorePatterns = [ "q" "exit" ];
        ignoreSpace = true;
        path = "${config.xdg.stateHome}/zsh/history";
        save = 10000000;
        saveNoDups = false;
        share = true;
        size = 10000000;
      };

      historySubstringSearch = {
        enable = true;
        searchDownKey = [ "^j" ];
        searchUpKey = [ "^k" ];
      };

      setOptions = [
        "MENU_COMPLETE"         # Auto-insert first match, cycle through with tab
        "INC_APPEND_HISTORY"    # Add commands to history immediately, not at shell exit
        "HIST_VERIFY"           # Show history expansion before executing (!!, !$, etc)
        "PROMPT_SUBST"          # Allow variable/command substitution in prompts
        "NO_BEEP"               # Disable terminal beep on errors
      ];

    };
  };
}
