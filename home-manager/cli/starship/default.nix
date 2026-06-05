{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let cfg = config.starship;
in {
  options.starship = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;

      settings = {
        "$schema" = "https://starship.rs/config-schema.json";

        add_newline = false;

        format = lib.concatStrings [
          "$os"
          "$hostname"
          "$sudo"
          "$jobs"
          "$directory"
          "$direnv"
          "$git_branch"
          "$git_status"
          "$c"
          "$rust"
          "$golang"
          "$nodejs"
          "$php"
          "$java"
          "$kotlin"
          "$haskell"
          "$python"
          "$zig"
          "$container"
          "$nix_shell"
          "$docker_context"
          "$line_break"
          "$character"
        ];

        palette = "gruvbox_dark";

        palettes.gruvbox_dark = {
          rosewater = "#ebdbb2";
          flamingo = "#d5c4a1";
          pink = "#d3869b";
          mauve = "#b16286";
          red = "#fb4934";
          maroon = "#cc241d";
          peach = "#fe8019";
          yellow = "#fabd2f";
          green = "#b8bb26";
          teal = "#8ec07c";
          sky = "#83c07c";
          sapphire = "#689d6a";
          blue = "#83a598";
          lavender = "#bdae93";

          text = "#ebdbb2";
          subtext1 = "#d5c4a1";
          subtext0 = "#bdae93";

          overlay2 = "#a89984";
          overlay1 = "#928374";
          overlay0 = "#7c6f64";

          surface2 = "#504945";
          surface1 = "#3c3836";
          surface0 = "#32302f";

          base = "#282828";
          mantle = "#1d2021";
          crust = "#141617";
        };

        os = {
          format = "[$symbol]($style)";
          style = "bold green";
          disabled = true;
        };

        hostname = {
          ssh_symbol = " ";
          ssh_only = true;
          disabled = false;
          style = "bold blue";
          format = "[$ssh_symbol](bold blue)[$hostname ](bold blue)";
          trim_at = "-";
        };

        sudo = {
          style = "fg:blue";
          symbol = " ";
          disabled = false;
        };

        directory = {
          style = "fg:pink";
          format = "[$path]($style)";
          truncation_length = 2;
          truncation_symbol = "";
          truncate_to_repo = true;

          substitutions = {
            "Documents" = "󰈙 ";
            "Downloads" = " ";
            "Music" = "󰝚 ";
            "Pictures" = " ";
            "Developer" = "󰲋 ";
          };
        };

        direnv = {
          disabled = false;
          detect_files = [ ".envrc" ".env" ];
          symbol = "[env]";
          format = "[[ $symbol](fg:rosewater)]($style)";
        };

        git_branch = {
          symbol = "";
          style = "fg:green";
          format = "[[ $symbol $branch](fg:lavender)]($style)";
        };

        git_status = {
          style = "fg:lavender";
          stashed = "[ \\($count\\)](lavender)";
          modified = "[ !\\($count\\)](peach)";
          staged = "[ +\\($count\\)](green)";
          untracked = "[ ?\\($count\\)](yellow)";
          deleted = "[ x\\($count\\)](red)";
          format = "[[ $all_status $ahead_behind](fg:lavender)]($style)";
        };

        c = {
          symbol = " ";
          style = "fg:bold teal";
          format = "[[ $symbol( $version)](fg:teal)]($style)";
        };

        rust = {
          symbol = "";
          style = "fg:teal";
          format = "[[ $symbol( $version)](fg:teal)]($style)";
        };

        golang = {
          symbol = "";
          style = "fg:teal";
          format = "[[ $symbol( $version)](fg:teal)]($style)";
        };

        zig = {
          symbol = " ";
          style = "fg:teal";
          format = "[[ $symbol( $version)](fg:teal)]($style)";
        };

        nodejs.disabled = true;
        php.disabled = true;
        java.disabled = true;
        kotlin.disabled = true;
        haskell.disabled = true;
        python.disabled = true;

        nix_shell = {
          symbol = " ";
          impure_msg = "impure";
          pure_msg = "pure";
          unknown_msg = "unknown";
          format = "[ $state(\\($name\\))](fg:blue)";
        };

        container = {
          symbol = " ";
          format = "[[ $symbol( $name)](fg:blue)]($style)";
        };

        docker_context.disabled = true;

        jobs = {
          symbol = " ";
          style = "red";
          number_threshold = 1;
          format = "[$symbol ]($style)";
        };

        line_break.disabled = false;

        character = {
          disabled = false;
          success_symbol = "[❯](bold fg:text)";
          error_symbol = "[❯](bold fg:red)";
          vimcmd_symbol = "[❮](bold fg:blue)";
          vimcmd_replace_one_symbol = "[❮](bold fg:purple)";
          vimcmd_replace_symbol = "[❮](bold fg:purple)";
          vimcmd_visual_symbol = "[❮](bold fg:lavender)";
        };
      };
    };

  };
}
