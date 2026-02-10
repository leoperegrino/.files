{
  lib,
  config,
  ...
}:
let
  cfg = config.modules.users.environment;
in
{
  options.modules.users = {
    environment.enable = lib.mkEnableOption "environment";
  };

  config = lib.mkIf cfg.enable {

    home = {
      preferXdgDirectories = true;
      shell.enableShellIntegration = true;
      sessionPath = [
        "${config.home.homeDirectory}/.local/bin"
      ];
    };

    home.shellAliases = {
      ls = "ls -1HX --group-directories-first --{color,classify}=auto";
      la = "ls -hlAv --time-style='+%F %R'";
      mv = "mv -iv";
      rm = "rm -iv";
      ln = "ln -iv";
      cp = "cp -iv";
      up = "cd ..";
      g = "git";
      vim = "nvim";
      mkdir = "mkdir -pv";
      tree = "tree -F -C --ignore-case";
      rg = "rg --smart-case";
      s = "systemctl";
      j = "journalctl -fb";
      q = "exit";
    } // ( let
      dotfile = file: "nvim --cmd 'cd ~/.files/' ~/.files/${file}";
    in {
      nixrc = dotfile "flake.nix";
      nvimrc = dotfile "config/nvim/lua/user/init.lua";
    });

    programs.readline = {
      enable = true;

      variables = {
        bell-style = "none";
        blink-matching-paren = true;
        colored-completion-prefix = true;
        colored-stats = true;
        completion-display-width = 0;
        completion-ignore-case = true;
        completion-map-case = true;
        convert-meta = false;
        editing-mode = "vi";
        expand-tilde = true;
        history-preserve-point = true;
        input-meta = true;
        mark-symlinked-directories = true;
        menu-complete-display-prefix = true;
        output-meta = true;
        page-completions = false;
        show-all-if-ambiguous = true;
        show-mode-in-prompt = true;
        skip-completed-text = true;
        vi-cmd-mode-string = ''\1\033[1;33m\2(cmd)\1\033[0m\2 \1\e[1 q\2'';
        vi-ins-mode-string = ''\1\033[1;32m\2(ins)\1\033[0m\2 \1\e[5 q\2'';
        visible-stats = true;
      };

      bindings = {
        "\t" = "menu-complete";
        "\\e[Z]" = "menu-complete-backward";
        "\\e[A]" = "history-search-backward";
        "\\e[B]" = "history-search-forward";
        "\\C-b" = "backward-char";
        "\\C-f" = "forward-char";
        "\\C-a" = "beginning-of-line";
        "\\C-e" = "end-of-line";
        "\\C-l" = "clear-screen";
        "\\C-k" = "kill-whole-line";
        "\\C-p" = "history-substring-search-backward";
        "\\C-n" = "history-substring-search-forward";
      };

      extraConfig = /* readline */ ''
        $if mode=vi
          set keymap vi-command
          "\C-l": clear-screen
          "\e[A]": history-search-backward
          "\e[B]": history-search-forward
          j: history-search-forward
          k: history-search-backward
        $endif
      '';
    };

    programs.less = {
      enable = true;
      options = {
        jump-target = ".3";
        QUIET = true;
        chop-long-lines = true;
        RAW-CONTROL-CHARS = true;
        ignore-case = true;
        clear-screen = true;
        tilde = true;
      };
      config = ''
        #command
        i quit

        j forw-line
        k back-line
        h left-scroll
        l right-scroll

        s noaction
      '';
    };

  };
}
