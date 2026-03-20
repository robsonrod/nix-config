{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let cfg = config.zsh;
in {
  options.zsh = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
      zsh-abbr.enable = true;

      initContent = ''
        autoload -Uz add-zsh-hook

        # blank line between prompts
        my_precmd() {
        [[ -n "$_blank_line_shown" ]] && print ""
        _blank_line_shown=1
        }

        add-zsh-hook precmd my_precmd
        PROMPT=$'%B%F{red}[%F{yellow}%n%F{green}@%F{blue}%m %F{magenta}%~ %F{cyan}$(git_prompt_info)$(git_prompt_status)%F{red}]%f%b \n%(?.%F{white}.%F{red}✖ %? )%f '

        source ${pkgs.grc}/etc/grc.zsh

      '';

      shellAliases = {
        l = "eza -l --color=always --group-directories-first";
        ls = "eza --color=always --group-directories-first";
        la = "eza -la --color=always --octal-permissions --group-directories-first -g --icons";
        ll = "eza -l --color=always --octal-permissions --group-directories-first";
        tree = "eza --tree";
        edit = "sudo -e";
        update = "sudo nixos-rebuild switch";
      };
      localVariables = {
        #PROMPT="%B%F{red}[%F{yellow}%n%F{green}@%F{blue}%m %F{magenta}%~ %F{cyan}\\$(git_prompt_info)\\$(git_prompt_status)%F{red}]\n%F{white} %f%b";
        #PROMPT="%B%F{red}[%F{yellow}%n%F{green}@%F{blue}%m %F{magenta}%~%F{red}]%F{white}%# %f%b";
        ZSH_THEME_GIT_PROMPT_PREFIX = "(";
        ZSH_THEME_GIT_PROMPT_SUFFIX = ")";
        ZSH_THEME_GIT_PROMPT_DIRTY = " %F{red}✗";
        ZSH_THEME_GIT_PROMPT_CLEAN = " %F{green}✓";
        ZSH_THEME_GIT_PROMPT_STAGED = " %F{yellow}●";
        ZSH_THEME_GIT_PROMPT_UNTRACKED = " %F{cyan}✚";
        ZSH_THEME_GIT_PROMPT_UNMERGED = " %F{red}✖";
        ZSH_THEME_GIT_PROMPT_AHEAD = " ⇡";
        ZSH_THEME_GIT_PROMPT_BEHIND = " ⇣";
      };

      sessionVariables = {
        ZOXIDE_CMD_OVERRIDE = "cd";

        OPENER = "xdg-open";
        GPG_TTY = "$(tty)";
        TERM = "xterm-256color";
        COLORTERM = "truecolor";
        VISUAL = "nvim";
        EDITOR = "$VISUAL";
        MANPAGER = "less";
        PAGER = "bat -P --style=grid --wrap=never";
        BROWSER = "firefox";
        FILE = "thunar";
        TERMINAL = "kitty";
        LSP_USE_PLISTS = "true";
      };

      history.size = 100000;
      history.ignoreAllDups = true;
      history.path = "$HOME/.zsh_history";
      history.ignorePatterns = [ "rm *" "pkill *" "cp *" ];

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git" # also requires `programs.git.enable = true;`
          "eza"
          "rust"
          "zoxide"
          "extract"
          "fzf"
          "ssh"
          "ufw"
          "grc"
          "colored-man-pages"
          "copyfile"
        ];
        #	theme = "simple";
      };
    };
  };
}
