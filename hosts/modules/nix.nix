{lib, config, ...}:
let
  cfg = config.modules.hosts.nix;
in {

  options.modules.hosts = {
    nix.enable = lib.mkEnableOption "nix settings";
    nix.unfreePkgs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };
  };

  config = lib.mkIf cfg.enable {

    nix = {
      settings = {
        use-xdg-base-directories = true;
        experimental-features = [ "nix-command" "flakes" ];
      };
      gc.automatic = false;
    };

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) cfg.unfreePkgs;
  };

}
