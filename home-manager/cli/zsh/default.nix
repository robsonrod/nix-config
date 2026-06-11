{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let cfg = config.zsh;
in
{
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
      historySubstringSearch.enable = true;
      zsh-abbr.enable = true;

      syntaxHighlighting = {
        enable = true;

        styles = {
          default = "fg=#ebdbb2";
          comment = "fg=#928374";

          command = "fg=#8ec07c";
          alias = "fg=#b8bb26";
          suffix-alias = "fg=#b8bb26";
          builtin = "fg=#fabd2f";
          function = "fg=#b8bb26";
          precommand = "fg=#83a598";

          reserved-word = "fg=#fe8019";

          single-hyphen-option = "fg=#fe8019";
          double-hyphen-option = "fg=#fe8019";

          path = "fg=#83a598,underline";
          globbing = "fg=#d3869b";

          history-expansion = "fg=#fb4934";
          unknown-token = "fg=#fb4934,bold";

          commandseparator = "fg=#d3869b";
          cursor = "fg=#ebdbb2";
        };
      };

      initContent = ''
        autoload -Uz add-zsh-hook

        export GPG_TTY=$(tty)

        my_precmd() {
          [[ -n "$_blank_line_shown" ]] && print ""
          _blank_line_shown=1
        }

        add-zsh-hook precmd my_precmd

        PROMPT='%B%F{yellow}[%F{green}%n%F{yellow}@%F{blue}%m %F{aqua}%~ %F{purple}$(git_prompt_info)$(git_prompt_status)%F{yellow}]%f%b%(?.%F{white} λ.%F{red} ✗ %? λ)%f '

        source ${pkgs.grc}/etc/grc.zsh

        export LESS_TERMCAP_mb=$'\e[1;38;5;203m'
        export LESS_TERMCAP_md=$'\e[1;38;5;214m'
        export LESS_TERMCAP_me=$'\e[0m'
        export LESS_TERMCAP_so=$'\e[48;5;237;38;5;223m'
        export LESS_TERMCAP_se=$'\e[0m'
        export LESS_TERMCAP_us=$'\e[4;38;5;142m'
        export LESS_TERMCAP_ue=$'\e[0m'

        export LESS='-R --use-color -Dd+r$Du+b'
        export GROFF_NO_SGR=1

        export FZF_DEFAULT_OPTS="
          --color=bg+:#3c3836,bg:#282828,spinner:#fabd2f,hl:#fb4934
          --color=fg:#ebdbb2,header:#fb4934,info:#d3869b,pointer:#fabd2f
          --color=marker:#b8bb26,fg+:#ebdbb2,prompt:#83a598,hl+:#fb4934
          --color=selected-bg:#504945
          --multi
        "

        export FZF_DEFAULT_COMMAND='
          rg --files \
            --follow \
            --hidden \
            --glob "!**/.git/*" \
            --glob "!**/node_modules/*" \
            --glob "!**/.venv/*"
        '
      '';

      shellAliases = {
        c = "clear";
        xx = "exit";
        h = "history";

        v = "nvim";
        e = "emacs -nw";
        edit = "sudo -e";

        btw = "fastfetch";

        wget = "wget --hsts-file=$XDG_CACHE_HOME/wget-hsts";

        clone = "git clone";
        adda = "git add . --all";
        addu = "git add -u";
        status = "git status";
        commit = "git commit -v -m";
        gdiff = "git diff";
        pull = "git pull";

        nr = "nh os switch";
        nt = "nh os test";
        nb = "nh os boot";
        nu = "nix flake update && nh os switch";
        nc = "nh clean all";
        ns = "nix search nixpkgs";
        ni = "nh os info";

        dev = "ssh dev";
      };

      localVariables = {
        ZSH_THEME_GIT_PROMPT_PREFIX = "(";
        ZSH_THEME_GIT_PROMPT_SUFFIX = ")";

        ZSH_THEME_GIT_PROMPT_DIRTY = " %F{red}●";
        ZSH_THEME_GIT_PROMPT_CLEAN = " %F{green}●";

        ZSH_THEME_GIT_PROMPT_STAGED = " %F{yellow}+";
        ZSH_THEME_GIT_PROMPT_UNTRACKED = " %F{blue}?";
        ZSH_THEME_GIT_PROMPT_UNMERGED = " %F{red}!";

        ZSH_THEME_GIT_PROMPT_AHEAD = " ↑";
        ZSH_THEME_GIT_PROMPT_BEHIND = " ↓";
      };

      sessionVariables = {
        ZOXIDE_CMD_OVERRIDE = "cd";

        TERM = "xterm-256color";
        COLORTERM = "truecolor";

        VISUAL = "nvim";
        EDITOR = "nvim";

        PAGER = "less";
        MANPAGER = "less";

        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=#928374";
      };

      history = {
        size = 100000;
        path = "$HOME/.zsh_history";

        ignoreAllDups = true;
        ignorePatterns = [
          "rm *"
          "pkill *"
        ];
      };

      oh-my-zsh = {
        enable = true;

        plugins = [
          "git"
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

      siteFunctions = {
        backupthis = ''
          cp -r -- "$1" "$1.bak.$(date +%Y%m%d%H%M%S)"
        '';

        getmac = ''
          ip -brief link \
          | awk '$1 != "lo" && $3 != "" { print $3; exit }'
        '';
      };

      plugins = [ ];
    };

    home.sessionVariables = {
      OPENER = "xdg-open";
      BROWSER = "firefox";
      FILE = "thunar";
      TERMINAL = "foot";
      LSP_USE_PLISTS = "true";
    };
  };
}
