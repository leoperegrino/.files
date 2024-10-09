{lib, config, pkgs, ... }:
let
  cfg = config.modules.hosts.programs;
in {

  options.modules.hosts = {
    programs.enable = lib.mkEnableOption "programs settings";
  };

  config = lib.mkIf cfg.enable {

    programs = {
      zsh = {
        enable = true;
        histSize = 100000;
        histFile = "\${XDG_STATE_HOME}/zsh/history";

        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;

        interactiveShellInit = ''
          source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
          '';
      };

      neovim = {
        enable = false;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
      };

      htop = {
        enable = true;
        package = pkgs.htop-vim;
        settings = {
          hide_kernel_threads = true;
          hide_userland_threads = true;
          tree_view = true;
          all_branches_collapsed = true;
          highlight_base_name = true;
          show_program_path = false;
          column_meters_0 = ["AllCPUs" "Memory"];
          column_meters_1 = ["DateTime" "System" "Battery" "Uptime" "Blank" "DiskIO" "NetworkIO"];
        };
      };
    };
  };

}
