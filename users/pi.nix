{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules
  ];

  modules.users.bat.enable = true;
  modules.users.git.enable = true;
  modules.users.gpg.enable = true;
  modules.users.nvim.enable = true;
  modules.users.ranger.enable = true;
  modules.users.xdg.enable = true;
  modules.users.htop.enable = true;

  home.username = "pi";
  home.homeDirectory = "/home/pi";

  programs.home-manager.enable = true;


  home.packages = with pkgs; [
  ];

  systemd.user.startServices = "sd-switch";

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
