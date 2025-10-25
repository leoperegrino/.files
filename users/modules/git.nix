{lib, config, ...}:
let
  cfg = config.modules.users.git;
in {

  options.modules.users = {
    git.enable = lib.mkEnableOption "git";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      delta.enable = true;
      extraConfig = {
        blame.date = "format:%Y-%m-%d %H:%M:%S";
        init.defaultBranch = "master";
        log.date = "iso-local";
        pager.status = false;
        pull.rebase = false;
        push.autoSetupRemote = true;
      };
      aliases = {
        b = "branch --list --all";
        ca = "commit --all";
        d = "diff";
        dev = "checkout develop";
        l = "log --graph --all";
        mas = "checkout master";
        master = "checkout master";
        mit = "commit --message";
        out = "checkout";
        p = "pull --all";
        rev-log = "rev-list --pretty --reverse --all --date=format:'%Y-%m-%d %H:%M:%S'";
        s = "status";
        ss = "show --show-signature";
        t = "log --graph --oneline --all";
        undo = "reset HEAD~1";
      };
      userName = "Leonardo Peregrino";
      userEmail = "55335068+leoperegrino@users.noreply.github.com";
      signing = {
        key = "AF88B50D5822448D";
        signByDefault = true;
      };
    };
  };

}
