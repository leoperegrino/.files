{lib, config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
    ./overlays.nix
  ];


}
