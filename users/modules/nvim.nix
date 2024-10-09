{pkgs, lib, config, ...}:
let
  cfg = config.modules.users.nvim;
in {

  options.modules.users = {
    nvim.enable = lib.mkEnableOption "nvim";
  };

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      extraPackages = with pkgs; [
        lua-language-server
      ];
    };
  };

}
