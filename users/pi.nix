{pkgs, ...}:
{

  imports = [
    ./modules/default.nix
  ];

  modules.users = {
    bat.enable = true;
    git.enable = true;
    gpg.enable = true;
    nvim.enable = true;
    ranger.enable = true;
    xdg.enable = true;
    htop.enable = true;
  };

  home.username = "pi";
  home.homeDirectory = "/home/pi";

  programs.home-manager.enable = true;


  home.packages = with pkgs; [
  ];

  systemd.user.startServices = "sd-switch";

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
