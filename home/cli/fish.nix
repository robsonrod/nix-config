{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let cfg = config.fish;
in {
  options.fish = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
          function fish_title
            true
          end

          function fish_greeting
          end

          if status --is-interactive
             eval (gpgconf --launch gpg-agent)
          end

          # general variables
          set -gx EDITOR nvim
          set -gx GPG_TTY (tty)
          set -gx COLORTERM truecolor
          set -gx TERM xterm-256color

          # general aliases
          abbr -a c clear
          abbr -a x exit
          abbr -a g git
          abbr -a h history
          abbr -a nv nvim
          abbr -a em emacs -nw
          abbr -a o xdg-open
          abbr -a m make
          abbr -a meminfo 'grc free -m -l -t'
          abbr -a top btm
          abbr -a .. 'cd ..'
          abbr -a 2. 'cd ../..'
          abbr -a 3. 'cd ../../..'
          abbr -a 4. 'cd ../../../..'
          abbr -a 5. 'cd ../../../../..'
          abbr -a cp 'cp -i'
          abbr -a mv 'mv -i'
          abbr -a rm 'rm -i'

         # exa or ls aliases
          if command -v eza >/dev/null
             alias l 'eza -l --color=always --group-directories-first --git'
             alias ls 'eza --color=always --group-directories-first --git'
             alias la 'eza -la --color=always --octal-permissions --group-directories-first -g --icons --git'
             alias ll 'eza -l --color=always --octal-permissions --group-directories-first --git'
             alias lt 'eza --tree --level=3 --long --icons --git'
          else
            alias l ls
            alias ls 'ls -l'
            alias la 'ls -la'
            alias ll 'ls -la'
          end

        # git aliases
        abbr -a add 'git add'
        abbr -a addu 'git add -u'
        abbr -a adda 'git add .'
        abbr -a gcl 'git clone'
        abbr -a gst 'git status'
        abbr -a commit 'git commit -v -m'
        abbr -a gcb 'git checkout -b'
        abbr -a gch 'git checkout'
        abbr -a gdf 'git diff'
        abbr -a glg 'git log --graph --pretty=format:\'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset\' --abbrev-commit --date=relative'
        abbr -a grm 'git rm'
        abbr -a gfetch 'git fetch --all --prune --verbose'
        abbr -a greset 'git reset HEAD'
        abbr -a gpl 'git pull'
        abbr -a gpp 'git pull && git push'
        abbr -a push 'git push origin'
        abbr -a gcl 'git clean -xfd'
        abbr -a branchd 'git branch -D'
        abbr -a master 'git checkout master'
        abbr -a stashl 'git stash lis'
        abbr -a stashp 'git stash pop'

        #work alias
        abbr -a dev 'ssh dev'

        # set colors
        set -Ux LS_COLORS $(vivid generate catppuccin-macchiato)
      '';
      plugins = [
        { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      ];
    };
  };
}
