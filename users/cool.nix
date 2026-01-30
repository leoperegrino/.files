{lib, pkgs, ...}:
{

  imports = [
    ./modules/default.nix
  ];

  modules.users = {
    bash.enable = true;
    bat.enable = true;
    environment.enable = true;
    git.enable = true;
    gpg.enable = true;
    htop.enable = true;
    neovim.enable = true;
    ranger.enable = true;
    xdg.enable = true;
    zsh.enable = true;
  };

  home.username = "cool";
  home.homeDirectory = "/home/cool";
  home.enableNixpkgsReleaseCheck = false;

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  ];

  home.packages = with pkgs; [
  ];

  systemd.user.startServices = "sd-switch";

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
