{lib, pkgs, ...}:
{

  imports = [
    ./modules/default.nix
  ];

  modules.users = {
    alacritty.enable = true;
    bat.enable = true;
    environment.enable = true;
    git.enable = true;
    gpg.enable = true;
    htop.enable = true;
    mpv.enable = true;
    neovim.enable = true;
    ranger.enable = true;
    syncthing.enable = true;
    xdg.enable = true;
    yazi.enable = true;
    zsh.enable = true;
  };

  home.username = "ltp";
  home.homeDirectory = "/home/ltp";
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
