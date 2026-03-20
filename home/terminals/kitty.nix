{ config, options, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.kitty;
in
{
  options.kitty = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      kitty = {
        enable = true;
        shellIntegration.enableFishIntegration = true;
        font = {
          name = "JetBrainsMono Nerd Font";
          package = pkgs.nerd-fonts.jetbrains-mono;
          size = 10;
        };

        settings = {
          font_family = "JetBrainsMono Nerd Font";
          bold_font = "auto";
          italic_font = "auto";
          bold_italic_font = "auto";
          enable_audio_bell = "false";
          scrollback_lines = "-1";
          tab_bar_edge = "top";
          allow_remote_control = "yes";
          #          shell_integration = "no-cursor";
          cursor_shape = "block";
          macos_option_as_alt = "yes";
          background_opacity = "1";
          adjust_line_height = "110%";
          select_by_word_characters = "@-./_~?&=%+#";
          repaint_delay = "10";
          term = "xterm-kitty";
          open_url_with = "default";
          cursor_blink_interval = "1";
          disable_ligatures = "always";
          window_border_width = "0";
          window_margin_width = "8";
          visual_bell_duration = "0.0";
          #          shell = "fish";
          tab_bar_background = "none";
          tab_bar_style = "powerline";
          tab_powerline_style = "slanted";
          tab_title_template = "{title}";
          active_tab_title_template = "{title}";
        };

        keybindings = {
          "super+v" = "paste_from_clipboard";
          "super+V" = "paste_from_selection";
          "super+c" = "copy_to_clipboard";
          "super+C" = "copy_to_selection";

          "ctrl+shift+right" = "next_tab";
          "ctrl+shift+left" = "previous_tab";
          "ctrl+shift+t" = "new_tab";
          "ctrl+shift+q" = "close_tab";
          "ctrl+shift+l" = "next_layout";
          "ctrl+shift+." = "move_tab_forward";
          "ctrl+shift+," = "move_tab_backward";

          "ctrl+l" = "clear_log_notice";

          "shift+up" = "scroll_line_up";
          "shift+down" = "scroll_line_down";
          "shift+page_up" = "scroll_page_up";
          "shift+page_down" = "scroll_page_down";
          "ctrl+shift+home" = "scroll_home";
          "ctrl+shift+end" = "scroll_end";

          "ctrl+equal" = "increase_font_size";
          "ctrl+minus" = "decrease_font_size";

          "ctrl+shift+n" = "no_op";
          "ctrl+k" = "no_op";
        };

        themeFile = "Catppuccin-Macchiato";

      };
    };
  };

}
