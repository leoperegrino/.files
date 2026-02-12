{ lib, config, ... }:
let
  cfg = config.modules.hosts.nix;
in
{

  options.modules.hosts = {
    nix.enable = lib.mkEnableOption "nix settings";
  };

  config = lib.mkIf cfg.enable {

    documentation.nixos.enable = false;

    nix = {
      settings = {
        use-xdg-base-directories = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
      gc.automatic = false;
    };
  };

}
