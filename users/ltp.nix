{ lib, pkgs, ... }:
{

  imports = [
    ./modules/default.nix
  ];

  modules.users = {
    alacritty.enable = true;
    bash.enable = true;
    bat.enable = true;
    environment.enable = true;
    git.enable = true;
    gpg.enable = true;
    htop.enable = true;
    mpv.enable = true;
    neovim.enable = true;
    python.enable = true;
    ranger.enable = true;
    syncthing.enable = true;
    tmux.enable = true;
    xdg.enable = true;
    yazi.enable = true;
    zsh.enable = true;
  };

  home.username = "ltp";
  home.homeDirectory = "/home/ltp";
  home.enableNixpkgsReleaseCheck = false;

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "drawio"
    "spotify"
    "slack"
  ];

  nixpkgs.config.permittedInsecurePackages = [
  ];

  home.packages = let p = pkgs; in [
    p.noto-fonts
    p.noto-fonts-cjk-sans
    p.noto-fonts-color-emoji
    p.slack
    p.jellyfin-media-player
    p.dbeaver-bin
    p.brave
    p.deluge
    p.drawio
    p.electrum
    p.element-desktop
    p.ffmpeg
    p.freetube
    p.keepassxc
    p.lazygit
    p.libreoffice-qt
    p.losslesscut-bin
    p.readest
    p.spotify
    p.tokei
    p.signal-desktop
    p.virtualenv
    p.vscodium-fhs
    p.yt-dlp
  ];

  systemd.user.startServices = "sd-switch";

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
