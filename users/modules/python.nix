{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.users.python;
in
{

  options.modules.users = {
    python.enable = lib.mkEnableOption "python";
  };

  config = lib.mkIf cfg.enable {

    home.packages = let p = pkgs; in [
      (p.python3.withPackages (py: [ py.ipython ]))
    ];

    home.sessionVariables = {
      PYTHON_HISTORY = "${config.xdg.stateHome}/python/history";
      PYTHONSTARTUP = "${config.xdg.configHome}/python/startup.py";
    };

    xdg.configFile."python/startup.py".text = /* python */ ''
      import atexit
      import os
      import readline
      import sys
      from pathlib import Path

      state = os.environ.get(
          'XDG_STATE_HOME',
          os.path.expanduser('~/.local/state')
      )

      histfile = Path(
          state,
          "python/history"
      )

      histfile.parent.mkdir(exist_ok=True)

      if sys.version_info <= (3, 13):
          try:
              readline.read_history_file(histfile)
              readline.set_history_length(-1)
          except FileNotFoundError:
              pass
          atexit.register(readline.write_history_file, histfile)
      else:
          pass
    '';
  };
}
