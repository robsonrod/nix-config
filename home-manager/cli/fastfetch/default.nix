{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.fastfetch;
  colors = {
    bg = "#282828";
    bg_alt = "#32302f";
    fg = "#d4be98";

    red = "#ea6962";
    orange = "#e78a4e";
    yellow = "#d8a657";
    green = "#a9b665";
    aqua = "#89b482";
    blue = "#7daea3";
    purple = "#d3869b";

    peach = "#e78a4e";
    teal = "#89b482";
    sky = "#7daea3";
    mauve = "#d3869b";
    pink = "#ea6962";
  };

in
{
  options.fastfetch = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.fastfetch = {
      enable = true;

      settings = {
        "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/master/doc/json_schema.json";

        display = {
          key.width = 15;
          separator = "";
          size.binaryPrefix = "jedec";
        };

        logo = {
          source = "${./logo.txt}";
          type = "file";
          color = {
            "1" = colors.red;
            "2" = colors.orange;
            "3" = colors.yellow;
            "4" = colors.green;
            "5" = colors.blue;
            "6" = colors.mauve;
          };
          padding.right = 4;
        };

        modules = [
          "break"
          "break"
          "break"
          "break"

          { type = "os"; key = "os"; keyColor = colors.blue; format = "{name} ({codename})"; }
          { type = "kernel"; key = "kernel"; keyColor = colors.green; }
          { type = "packages"; key = "pkgs"; keyColor = colors.yellow; }
          { type = "shell"; key = "shell"; keyColor = colors.mauve; format = "{pretty-name}"; }

          {
            type = "terminal";
            key = "terminal";
            keyColor = colors.sky;
            format = "{pretty-name}";
          }

          { type = "wm"; key = "wm"; keyColor = colors.pink; format = "{pretty-name}"; }
          { type = "uptime"; key = "up"; keyColor = colors.teal; }
          { type = "cpu"; key = "cpu"; keyColor = colors.red; format = "{name}"; }
          { type = "memory"; key = "ram"; keyColor = colors.peach; format = "{used} / {total}"; }

          {
            type = "disk";
            key = "disk";
            keyColor = colors.sky;
            folders = [ "/" ];
            format = "{size-used} / {size-total}";
          }

          "break"

          {
            type = "custom";
            format = "{#33}󰮯  {#34}󰊠  {#36}󰊠  {#35}󰊠  {#34}󰊠  {#39}󰊠  {#32}󰊠  {#31}󰊠 ";
          }

        ];
      };
    };
  };
}
