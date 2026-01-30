{lib, config, ... }:
let
  cfg = config.modules.hosts.environment;
in {

  options.modules.hosts = {
    environment.enable = lib.mkEnableOption "environment settings";
  };

  config = lib.mkIf cfg.enable {

    environment = {
      extraInit = /* sh */ ''
        export   XDG_DATA_HOME="''${HOME}/.local/share"
        export  XDG_STATE_HOME="''${HOME}/.local/state"
        export  XDG_CACHE_HOME="''${HOME}/.cache"
        export XDG_CONFIG_HOME="''${HOME}/.config"
      '';

      etc."bashrc.local".text = let
        profile = "\${XDG_CONFIG_HOME}/sh/profile";
        bashrc = "\${XDG_CONFIG_HOME}/bash/bashrc";
      in /* sh */ ''
        if test -f "${profile}"; then
          source "${profile}"
        fi
        if test -f "${bashrc}"; then
          source "${bashrc}"
        fi
      '';
    };
  };

}
