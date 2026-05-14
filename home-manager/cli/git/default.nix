{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let cfg = config.git;
in {
  options.git = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    catppuccin = {
      delta = {
        enable = true;
        flavor = "macchiato";
      };
    };

    programs.delta = {
      enableGitIntegration = true;
      enable = true;
    };

    programs.git = {
      enable = true;

      settings = {
        user.name = "Robson Rodrigues";
        user.email = "robsonrod@gmail.com";

        alias = {

          ci = "commit";
          st = "status";
          co = "checkout";
          cob = "checkout -b";

          df = "diff -b";

          ls = "log --oneline";

          lg =
            "log --graph "
            + "--pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' "
            + "--abbrev-commit --date=relative";

          last = "log -1 HEAD";
          sl = "stash list";
          pus = "push origin HEAD";
          pul = "pull --rebase";
          unstage = "restore --staged";
          amend = "commit --amend --no-edit";
          rb = "rebase";
        };

        apply.whitespace = "fix";

        color = {
          ui = "auto";
          interactive = "auto";
          status = "auto";
        };

        color.branch = {
          current = "yellow reverse";
          local = "yellow";
          remote = "green";
        };

        color.diff = {
          meta = "yellow bold";
          frag = "magenta bold";
          old = "red bold";
          new = "green bold";
        };

        color.alias = {
          added = "yellow";
          changed = "green";
          untracked = "cyan";
        };

        merge.tool = "vimdiff";

        core = {
          pager = "delta";
          editor = "nvim";
        };

        credential.helper = "cache --timeout=36000";
        init.defaultBranch = "main";
        fetch.prune = true;
        push.autoSetupRemote = true;
        rerere.enabled = true;
      };

      includes = [
        {
          path = "~/.config/git/gituser-default";
        }

        {
          condition = "gitdir:~/dotfiles/**";
          path = "~/.config/git/gituser-personal";
        }

        {
          condition = "gitdir:~/.emacs.d/**";
          path = "~/.config/git/gituser-personal";
        }

        {
          condition = "gitdir:~/dev/personal/**";
          path = "~/.config/git/gituser-personal";
        }

        {
          condition = "gitdir:~/nix-config/**";
          path = "~/.config/git/gituser-personal";
        }

        {
          condition = "gitdir:~/dev/work/**";
          path = "~/.config/git/gituser-work";
        }
      ];

    };

    home.file = {
      ".config/git/gituser-personal" = {
        text = ''
          #[commit]
          # gpgsign = true

          # https://gist.github.com/Kovrinic/ea5e7123ab5c97d451804ea222ecd78a
          [url "git@github.com:"]
          insteadOf = https://github.com/

          [url "git@codeberg.org:"]
          insteadOf = https://codeberg.org/
        '';
      };
    };
  };
}

