{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.tmux;
in
{
  options.tmux = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      tmux = {
        enable = true;

        mouse = true;
        keyMode = "vi";

        prefix = "M-z";

        escapeTime = 0;

        baseIndex = 1;

        historyLimit = 1000000;

        terminal = "xterm-256color";

        plugins = with pkgs.tmuxPlugins; [
          sensible
          yank
          vim-tmux-navigator

          {
            plugin = minimal-tmux-status;

            extraConfig = ''
              set -g @minimal-tmux-fg "#141617"
              set -g @minimal-tmux-bg "#e78a4e"
              set -g @minimal-tmux-justify "left"
              set -g @minimal-tmux-indicator-str " tmux "
              set -g @minimal-tmux-right false
              set -g @minimal-tmux-status "bottom"
              set -g @minimal-tmux-use-arrow false
            '';
          }
        ];

        extraConfig = ''
          #### STATUS BAR ####
          set -g status on
          set -g status-position bottom

          set -g default-terminal "xterm-256color"
          set -sa terminal-overrides ",xterm-256color:Tc"

          setw -g mode-keys vi
          set -g status-keys vi

          #### SPLITS ####
          bind | split-window -h -c "#{pane_current_path}"
          bind - split-window -v -c "#{pane_current_path}"

          bind c new-window -c "#{pane_current_path}"

          #### POPUP / SCRATCH ####
          bind g display-popup -E "tmux new-session -A -s scratch"

          #### UNBIND DEFAULTS ####
          unbind '"'
          unbind %

          #### PANE NAVIGATION (vim style) ####
          bind h select-pane -L
          bind j select-pane -D
          bind k select-pane -U
          bind l select-pane -R

          bind -n M-h select-pane -L
          bind -n M-j select-pane -D
          bind -n M-k select-pane -U
          bind -n M-l select-pane -R

          bind -n M-Left select-pane -L
          bind -n M-Right select-pane -R
          bind -n M-Up select-pane -U
          bind -n M-Down select-pane -D

          #### WINDOW NAVIGATION ####
          bind -n S-Left previous-window
          bind -n S-Right next-window

          bind -n M-H previous-window
          bind -n M-L next-window

          #### COPY MODE ####
          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi C-v send-keys -X begin-selection
          bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

          #### RELOAD ####
          bind r refresh-client

          set -g status-style bg='#141617',fg='#d4be98'
        '';
      };
    };

  };

}

