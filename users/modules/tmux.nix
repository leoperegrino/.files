{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.modules.users.tmux;
in
{
  options.modules.users = {
    tmux.enable = lib.mkEnableOption "tmux";
  };

  config = lib.mkIf cfg.enable {

    programs.tmux = {
      enable = true;

      mouse = true;
      escapeTime = 0;
      keyMode = "vi";
      historyLimit = 10000;
      baseIndex = 1;
      terminal = "xterm-256color";

      prefix = "C-q";

      extraConfig = /* tmux */ ''
        # Monitor settings
        set-option -g monitor-activity on
        set-option -g monitor-bell off
        set-option -g visual-activity off

        # History file
        set-option -g history-file ${config.xdg.stateHome}/tmux/history

        # Display settings
        set-option -g display-time 4000
        set-option -g status-interval 5

        # Prefix key bindings
        bind-key -T prefix C-q send-prefix
        unbind-key -T prefix C-b
        unbind-key -T prefix C-z
        unbind-key -T prefix z

        # Window splitting
        bind-key -T prefix C-w split-window -h -c "#{pane_current_path}" -l 35%
        bind-key -T prefix C-e split-window -v -c "#{pane_current_path}" -l 35%

        # Pane navigation
        bind-key -r -T prefix C-h select-pane -L
        bind-key -r -T prefix C-j select-pane -D
        bind-key -r -T prefix C-k select-pane -U
        bind-key -r -T prefix C-l select-pane -R

        # Window navigation
        bind-key -r -T prefix C-p previous-window
        bind-key -r -T prefix C-n next-window
        bind-key -r -T prefix C-c new-window -c "#{pane_current_path}"
        bind-key -r -T prefix C-v new-window -c "#{pane_current_path}" ${pkgs.neovim}/bin/nvim
        bind-key -r -T prefix C-y new-window -c "#{pane_current_path}" ${pkgs.yazi}/bin/yazi

        # Pane resizing
        bind-key -r -T prefix h resize-pane -L 5
        bind-key -r -T prefix j resize-pane -D 5
        bind-key -r -T prefix k resize-pane -U 5
        bind-key -r -T prefix l resize-pane -R 5

        # Other bindings
        bind-key -r -T prefix C-f resize-pane -Z
        bind-key -r -T prefix C-o last-pane
        bind-key -r -T prefix f display-popup -E
        bind-key -r -T prefix C-r source ${config.xdg.configHome}/tmux/tmux.conf \; display-message "Config reloaded"
        bind-key -r -T prefix \; command-prompt

        # Copy mode bindings
        bind-key -T prefix C-space copy-mode
        bind-key -T prefix p paste-buffer
        bind-key -T copy-mode-vi i send-keys -X cancel
        bind-key -T copy-mode-vi 'v' send -X begin-selection
        bind-key -T copy-mode-vi 'y' send -X copy-selection
        bind-key -T copy-mode-vi 'Space' send -X halfpage-down
        bind-key -T copy-mode-vi 'd' send -X halfpage-down
        bind-key -T copy-mode-vi 'u' send -X halfpage-up

        # Terminal overrides
        set-option -as terminal-overrides ",alacritty*:Tc"

        # gitsigns colorscheme
        GREEN=#6a9955
        BLACK=#1f1f1f
        YELLOW=#dcdcaa
        RED=#f44747

        # Separators
        LSF="\uE0B4"
        LS="\uE0B5"
        RSF="\uE0B6"
        RS="\uE0B7"

        # Status bar styling
        set-option -g window-status-style           bg=''${BLACK},fg=''${YELLOW}
        set-option -g window-status-current-style   bg=''${BLACK},fg=''${GREEN}
        set-option -g window-status-activity-style  fg=''${RED}
        set-option -g window-status-format          " #{?window_activity_flag,!,}#{window_name}#{?window_zoomed_flag,+,} "
        set-option -g window-status-current-format  "''${RS} #{window_name}#{?window_zoomed_flag,+,} ''${LS}"
        set-option -g status-justify centre
        set-option -g status-left-style  bg=''${GREEN},fg=''${BLACK}
        set-option -g status-style       bg=''${BLACK},fg=''${GREEN}
        set-option -g status-right-style bg=''${BLACK},fg=''${GREEN}
        set-option -g status-left-length 1000
        set-option -g status-right-length 1000
        set-option -g status-left    "  s:#{session_name} ''${LS}  w:#{window_index}  #[fg=''${GREEN}]#[bg=''${BLACK}]''${LSF}  "
        set-option -g status-right   " ''${RSF}#[fg=''${BLACK}]#[bg=''${GREEN}]  %H:%M  ''${RS}  %d-%b-%y  "
      '';
    };
  };
}
