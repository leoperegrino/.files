{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.users.yazi;
  flavors = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "flavors";
    rev = "ffe6e3a16c5c51d7e2dedacf8de662fe2413f73a";
    hash = "sha256-hEnrvfJwCAgM12QwPmjHEwF5xNrwqZH1fTIb/QG0NFI=";
  };
  everforest-medium = pkgs.fetchFromGitHub {
    owner = "Chromium-3-Oxide";
    repo = "everforest-medium.yazi";
    rev = "0158f0f6ce19c9bbc37550a7bed77d67b3fa4e7d";
    hash = "sha256-Ooe21D2nUGRziu7ot2erE5EEaWqp21jTrbgZH/sZRAk=";
  };
in {

  options.modules.users = {
    yazi.enable = lib.mkEnableOption "yazi";
  };

  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      package = pkgs.yazi;
      extraPackages = [
        pkgs.bat
        pkgs.ueberzugpp
        pkgs.hexyl
      ];

      flavors = {
        catppuccin-mocha = "${flavors}/catppuccin-mocha.yazi";
        everforest-medium = everforest-medium;
      };

      theme = {
        flavor = {
          dark = "everforest-medium";
          light = "catppuccin-mocha";
        };
        icon = {
          dirs = [
            { name = "desktop"    ; text = ""; }
            { name = "documents"  ; text = ""; }
            { name = "downloads"  ; text = ""; }
            { name = "music"      ; text = ""; }
            { name = "pictures"   ; text = ""; }
            { name = "public"     ; text = ""; }
            { name = "videos"     ; text = ""; }
            { name = "syncthing"  ; text = ""; }
            { name = "mnt"        ; text = ""; }
          ];
        };
      };

      plugins = {
        inherit (pkgs.yaziPlugins)
          full-border
          vcs-files
          smart-enter
          smart-filter
          git
          toggle-pane
          piper
        ;
      };

      keymap = {
        mgr = {
          prepend_keymap = [
            { on = [ "g" "c" ];   run = "cd ~/.config"; }
            { on = [ "g" "C" ];   run = "cd ~/.cache"; }
            { on = [ "g" "u" ];   run = "cd ~/.local/share"; }
            { on = [ "g" "s" ];   run = "cd ~/.local/state"; }
            { on = [ "g" "b" ];   run = "cd ~/bin"; }
            { on = [ "g" "f" ];   run = "cd ~/.files"; }
            { on = [ "g" "p" ];   run = "cd ~/pictures"; }
            { on = [ "g" "v" ];   run = "cd ~/videos"; }
            { on = [ "g" "d" ];   run = "cd ~/documents"; }
            { on = [ "g" "D" ];   run = "cd ~/desktop"; }
            { on = [ "g" "w" ];   run = "cd ~/downloads"; }
            { on = [ "g" "e" ];   run = "cd /etc"; }
            { on = [ "g" "U" ];   run = "cd /usr"; }
            { on = [ "g" "t" ];   run = "cd /tmp"; }
            { on = [ "g" "V" ];   run = "cd /var"; }

            { on = [ "g" "F" ];   run = "follow"; desc = "Follow hovered symlink"; }

            { on = [ "k" ];       run = "arrow -1"; }
            { on = [ "j" ];       run = "arrow 1"; }
            { on = [ "K" ];       run = "arrow -50%"; }
            { on = [ "J" ];       run = "arrow 50%"; }
            { on = [ "q" ];       run = "close"; }

            { on = [ "<c-c>" ];   run = "quit"; }
            { on = [ "<C-o>" ];   run = "create"; }
            { on = [ "<C-h>" ];   run = "hidden toggle"; }
            { on = [ "<C-n>" ];   run = "tab_create --current"; }
            { on = [ "W" ];       run = "spot"; }

            { on = [ "<Tab>" ];       run = "tab_switch --relative 1"; }
            { on = [ "<BackTab>" ];   run = "tab_switch --relative -1"; }

            { on = [ "v" ];       run = "toggle_all"; }
            { on = [ "y" "y" ];   run = "yank"; }
            { on = [ "d" "d" ];   run = "yank --cut"; }
            { on = [ "d" "t" ];   run = "remove"; }
            { on = [ "d" "D" ];   run = "remove --permanently"; }
            { on = [ "p" "p" ];   run = "paste"; }
            { on = [ "p" "l" ];   run = "link --relative"; }
            { on = [ "p" "L" ];   run = "link"; }
            { on = [ "p" "h" ];   run = "hardlink"; }

            { on = [ "f" ];       run = "find --smart"; }
            { on = [ "/" ];       run = "filter --smart"; }
            { on = [ "?" ];       run = "help"; }

            { on = [ "S" ];       run = "shell --block $SHELL"; }
            { on = [ "i" ];       run = "shell --block -- bat --style=full --color=always \"$0\""; }
            { on = [ "b" ];       run = "shell --orphan -- alacritty"; }
            { on = [ "m" "d" ];   run = "shell --block --interactive -- mkdir -- "; }

            { on = [ "e" "e" ];   run = "shell --block -- nvim -- \"$0\""; }
            { on = [ "e" "v" ];   run = "shell --block -- nvim -- \"$0\""; }
            { on = [ "e" "E" ];   run = "shell --block --interactive -- nvim -- "; }
            { on = [ "e" "s" ];   run = "shell --block -- nvim -O -- $@"; }
            { on = [ "E" "V" ];   run = "shell --block -- sudo nvim -- $0"; }
            { on = [ "V" ];       run = "shell --orphan -- alacritty -e nvim -- $0"; }

            { on = [ "T" ];       run = "plugin toggle-pane min-preview"; }
            { on = [ "F" ];       run = "plugin smart-filter"; }
            { on = [ "l" ];       run = "plugin smart-enter"; }
            { on = [ "<Enter>" ]; run = "plugin smart-enter"; }
            { on = [ "g" "i" ];   run = "plugin vcs-files"; }

            { on = [ "a" ];       run = "rename --cursor=before_ext"; }
            { on = [ "I" ];       run = "rename --cursor=start"; }
            { on = [ "A" ];       run = "rename --cursor=end"; }
            { on = [ "r" ];       run = "rename --empty=stem --cursor=start"; }
            { on = [ "R" ];       run = "rename --empty=all"; }
          ];
        };
      };

      settings = {
        mgr = {
          linemode = "size";
        };
        plugin = {
          prepend_previewers = let bat = "piper -- bat --style=full --color=always \"$1\""; in [
            { name = "*.lua"; run = bat; }
            { name = "*.md"; run = bat; }
            { mime = "text/*"; run = bat; }
            { mime = "application/json"; run = bat; }
          ];
          append_previewers = [
            { name = "*"; run = "piper -- hexyl --terminal-width=$w \"$1\""; }
          ];
          prepend_fetchers = [
            { id = "git"; name = "*"; run = "git"; }
            { id = "git"; name = "*/"; run = "git"; }
          ];
        };
      };

      initLua = /* lua */ ''
        -- For full-border plugin
        require("full-border"):setup({
          type = ui.Border.ROUNDED,
        })

        -- https://yazi-rs.github.io/docs/tips/#user-group-in-status
        Status:children_add(function()
          local h = cx.active.current.hovered
          if not h or ya.target_family() ~= "unix" then
            return ""
          end

          return ui.Line {
            ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
            ":",
            ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
            " ",
          }
        end, 500, Status.RIGHT)

        -- https://yazi-rs.github.io/docs/tips/#username-hostname-in-header
        Header:children_add(function()
          if ya.target_family() ~= "unix" then
            return ""
          end
          return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
        end, 500, Header.LEFT)

        -- for git.yazi
        th.git = th.git or {}
        th.git.added_sign = "a"  -- ""
        th.git.deleted_sign = "d"  -- ""
        th.git.ignored_sign = "i"  -- ""
        th.git.modified_sign = "m"  -- ""
        th.git.untracked_sign = "?"  -- "u"
        th.git.updated_sign = "up"  -- ""
        require("git"):setup()
      '';

    };
  };

}
