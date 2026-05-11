{ config, options, lib, pkgs, vars, ... }:

with lib;
with lib.types;
let cfg = config.myconfig.thunar;
in
{
  options.myconfig.thunar = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {

    xdg.configFile."Thunar/uca.xml".text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <actions>
        <action>
          <icon>utilities-terminal</icon>
          <name>Open Terminal Here</name>
          <submenu></submenu>
          <unique-id>1234567890123456-1</unique-id>
          <command>ghostty --working-directory=%f</command>
          <description>Open terminal in selected directory</description>
          <patterns>*</patterns>
          <directories/>
        </action>

        <action>
          <icon>system-file-manager</icon>
          <name>Edit with Neovim</name>
          <submenu></submenu>
          <unique-id>1234567890123456-2</unique-id>
          <command>ghostty nvim %f</command>
          <description>Edit file with Neovim</description>
          <patterns>*</patterns>
          <text-files/>
        </action>
      </actions>
    '';
  };

}
