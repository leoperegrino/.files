{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules
  ];

  modules.users.enable = true;

  home.username = "ltp";
  home.homeDirectory = "/home/ltp";

  programs.home-manager.enable = true;


  home.packages = with pkgs; [
  ];

  systemd.user.startServices = "sd-switch";

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
