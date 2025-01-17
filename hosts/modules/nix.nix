{lib, config, ...}:
let
  cfg = config.modules.hosts.nix;
in {

  options.modules.hosts = {
    nix.enable = lib.mkEnableOption "nix settings";
  };

  config = lib.mkIf cfg.enable {

    nix = {
      settings = {
        use-xdg-base-directories = true;
        experimental-features = [ "nix-command" "flakes" ];
      };
      gc = {
        options = "--delete-older-than 7d";
        automatic = true;
        dates = "weekly";
      };
    };
  };

}
