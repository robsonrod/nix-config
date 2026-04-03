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
      syntaxHighlighting = {
        enable = true;
        styles.cursor = "fg=#cdd6f4";
      };
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
                PROMPT='%B%F{red}[%F{yellow}%n%F{green}@%F{blue}%m %F{magenta}%~ %F{cyan}$(git_prompt_info)$(git_prompt_status)%F{red}]%f%b%(?.%F{white} $.%F{red}✖ %? $ )%f '

                source ${pkgs.grc}/etc/grc.zsh

        	export LESS_TERMCAP_mb=$'\e[1;38;5;203m'
        	export LESS_TERMCAP_md=$'\e[1;38;5;111m'
        	export LESS_TERMCAP_me=$'\e[0m'
        	export LESS_TERMCAP_so=$'\e[48;5;236;38;5;223m'
        	export LESS_TERMCAP_se=$'\e[0m'
        	export LESS_TERMCAP_us=$'\e[4;38;5;150m'
        	export LESS_TERMCAP_ue=$'\e[0m'
        	export LESS='-R --use-color -Dd+r$Du+b'
        	export GROFF_NO_SGR=1		

        	export FZF_DEFAULT_OPTS=" \
        	--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
        	--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
        	--color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
        	--color=selected-bg:#494d64 --multi"
        	export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/,.git/,.venv/}"'

      '';

      shellAliases = {
        l = "eza -l --color=always --group-directories-first";
        ls = "eza --color=always --group-directories-first";
        la = "eza -la --color=always --octal-permissions --group-directories-first -g --icons";
        ll = "eza -l --color=always --octal-permissions --group-directories-first";
        tree = "eza --tree";
        edit = "sudo -e";
        update = "sudo nixos-rebuild switch";
        c = "clear";
        xx = "exit";
        h = "history";
        v = "nvim";
        e = "emacs -nw";
        btw = "macchina";
        wget = "wget --hsts-file=$XDG_CACHE_HOME/wget-hsts";
      };

      localVariables = {
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
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=white";
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
          "fancy-ctrl-z"
          "history-substring-search"
        ];
      };

      plugins = [
        {
          name = "catppuccin/zsh-syntax-highlighting";
          file = "catppuccin_macchiato-zsh-syntax-highlighting.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "zsh-syntax-highlighting";
            rev = "7926c3d3e17d26b3779851a2255b95ee650bd928";
            sha256 = "sha256-l6tztApzYpQ2/CiKuLBf8vI2imM6vPJuFdNDSEi7T/o=";
          };
        }
      ];

    };
  };
}
