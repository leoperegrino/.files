{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.users.neovim;

  symlink = config.lib.file.mkOutOfStoreSymlink;
  home = config.home.homeDirectory;
  dotfiles = "${home}/.files/config";
in
{

  options.modules.users = {
    neovim.enable = lib.mkEnableOption "neovim";
  };

  config = lib.mkIf cfg.enable {

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      extraPackages = let p = pkgs; in [
        p.lua-language-server
        p.nixfmt-rfc-style
        p.tree-sitter
        p.gcc
        p.nil
        p.nixd
        p.ripgrep  # telescope
      ];
    };

    xdg.configFile = {

      "nvim/parser" = {
        source = let parsers = pkgs.symlinkJoin {
          name = "treesitter-parsers";
          paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
        };
        in "${parsers}/parser";
      };

      "nvim/lua" = {
        source = symlink "${dotfiles}/nvim/lua";
        recursive = true;
      };

      "nvim/init.lua" = {
        source = symlink "${dotfiles}/nvim/init.lua";
      };

      "nvim/lazy-lock.json" = {
        source = symlink "${dotfiles}/nvim/lazy-lock.json";
      };

    };

  };

}
