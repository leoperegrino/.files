{
  lib,
  config,
  pkgs-unstable,
  ...
}:
let
  cfg = config.modules.users.neovim;
in
{

  options.modules.users = {
    neovim.enable = lib.mkEnableOption "neovim";
  };

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      package = pkgs-unstable.neovim-unwrapped;
      extraPackages = with pkgs-unstable; [
        lua-language-server
        tree-sitter
        gcc
        nil
      ];
    };
  };

}
