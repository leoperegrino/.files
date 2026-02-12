{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.users.ranger;
in {

  options.modules.users = {
    ranger.enable = lib.mkEnableOption "ranger";
  };

  config = lib.mkIf cfg.enable {

    programs.ranger = {
      package = pkgs.ranger.overrideAttrs (prev: {
        makeWrapperArgs = ["--set BAT_STYLE full"];
        preConfigure = let
          json_bat_cmd = ''jq . "''${FILE_PATH}" | env COLORTERM=8bit bat --language json --color=always --style="''${BAT_STYLE}" \&\& exit 5'';
        in
        prev.preConfigure + ''
          sed -i -e '/#\s*application\/pdf/,/&& exit 6/s/#//' ranger/data/scope.sh
          sed -i -e '/#\s*video/,/exit 1/s/#//' ranger/data/scope.sh
          sed -i -e 's/json)/&\n\t\t\t${json_bat_cmd}/' ranger/data/scope.sh
          sed -i -e '/handle_mime() {/,/esac/s/case "''${mimetype}" in/&\n\n\t\tapplication\/json) ${json_bat_cmd} ;;\n/' ranger/data/scope.sh
          sed -i -e 's/text\/\* | \*\/xml)/text\/* | *\/xml | application\/javascript)/g' ranger/data/scope.sh
        '';
      });
      enable = true;
      extraPackages = [
        pkgs.ueberzugpp
        pkgs.ffmpegthumbnailer
        pkgs.poppler-utils
        pkgs.jq
        pkgs.bat
      ];
      extraConfig = "default_linemode devicons";
      plugins = [{
        name = "devicons";
        src = builtins.fetchGit {
          url = "https://github.com/alexanderjeurissen/ranger_devicons.git";
          rev = "1bcaff0366a9d345313dc5af14002cfdcddabb82";
        };
      }];
      settings = {
        preview_images_method = "ueberzug";
        use_preview_script  = true;
        preview_images  = true;
        preview_files  = true;
        open_all_images  = true;
        draw_borders  = true;
        hidden_filter  = ''^\.|\.(bak|swp)$|^lost\+found$|^__pycache__$'';
        nested_ranger_warning  = true;
        colorscheme  = "jungle";
      };
      mappings = {
        "gu" = "cd ~/.local/share";
        "gs" = "cd ~/.local/state";
        "gf" = "cd ~/.files";
        "gV" = "cd ~/.files/config/nvim/lua/user/";
        "gc" = "cd ~/.config";
        "gC" = "cd ~/.cache";
        "gb" = "cd ~/.local/bin";
        "gD" = "cd ~/desktop";
        "gd" = "cd ~/documents";
        "gm" = "cd ~/music";
        "gp" = "cd ~/pictures";
        "gv" = "cd ~/videos";
        "gU" = "cd /usr/share/";
        "gr" = "cd /";
        "gt" = "cd /tmp";
        "g/r" = "shell sudo ranger .";

        "ev" = ''shell "''${EDITOR}" -- %s'';
        "eV" = ''console shell "''${EDITOR}" --%space'';
        "et" = ''shell "''${EDITOR}" -p -- %s'';
        "eT" = ''console shell "''${EDITOR}" -p -- %s%space'';
        "es" = ''shell "''${EDITOR}" -O -- %s'';
        "eS" = ''console shell "''${EDITOR}" -O -- %s%space'';
        "EV" = ''shell sudo "''${EDITOR}" -- %s'';
        "V" = ''shell setsid -f ${pkgs.alacritty}/bin/alacritty -e zsh -ic "''${EDITOR} -- %s"'';
        "B" = ''shell setsid -f ${pkgs.alacritty}/bin/alacritty -e zsh -ic "''${PAGER} -- %s"'';
        "<c-o>" = "console touch%space";

        "yi" = ''shell ${pkgs.xclip}/bin/xclip -sel clip -t image/png %f'';
        "CC" = "get_cumulative_size";
        "md" = "console mkdir%space";
        "cW" = "bulkrename";
        "T"  = "toggle_flat";
        "i" = ''shell "''${PAGER}" -- %f'';
        "v" = "mark_files all=True toggle=True";
        "n" = "tab_new";
        "b" = ''shell setsid -f alacritty -e zsh'';
        "f" = "console scout -ftse%space";
        "<c-j>" = "scroll_preview 1";
        "<c-k>" = "scroll_preview -1";
      };
    };

    xdg.configFile."ranger/commands.py".text = /* python */ ''
      from ranger.api.commands import Command

      class toggle_flat(Command):
          """
          :toggle_flat

          Flattens or unflattens the directory view.
          """
          def execute(self):
            if self.fm.thisdir.flat == 0:
                self.fm.thisdir.unload()
                self.fm.thisdir.flat = -1
                self.fm.thisdir.load_content()
            else:
                self.fm.thisdir.unload()
                self.fm.thisdir.flat = 0
                self.fm.thisdir.load_content()
    '';

  };

}
