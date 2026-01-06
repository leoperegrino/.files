{
  lib,
  config,
  pkgs,
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
      package = pkgs.neovim-unwrapped;
      extraPackages = let p = pkgs; in [
        p.lua-language-server
        p.nixfmt-rfc-style
        p.tree-sitter
        p.gcc
        p.nil
        p.nixd
      ];
    };
  };

}
