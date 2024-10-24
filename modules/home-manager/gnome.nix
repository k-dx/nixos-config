{ config, pkgs, lib, ... }:

with lib.hm.gvariant;

{
  # based on https://heywoodlh.io/nixos-gnome-settings-and-keyboard-shortcuts
  dconf.settings = {
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
    };
    "org/gnome/desktop/input-sources" = {
      show-all-sources = true;
      sources = [
        [ "xkb" "pl" ] [ "xkb" "eu" ]
      ];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      document-font-name="Source Sans 3 Ultra-Light 13";
      font-name="Source Sans 3 Semi-Bold 13";
      monospace-font-name="Source Code Pro 13";
      text-scaling-factor = 1.15;
      cursor-size = 32;
      show-battery-percentage=true;
    };
    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 0;
    };
    "org/gnome/shell" = {
       enabled-extensions = [
         "appindicatorsupport@rgcjonas.gmail.com"
         "pop-shell@system76.com"
         # "wsmatrix@martin.zurowietz.de"
       ];
       favorite-apps = [
         "firefox.desktop"
         "org.gnome.Console.desktop"
         "code.desktop"
         "org.gnome.Nautilus.desktop"
         "dev.zed.Zed.desktop"
      ];
    };
    "org/gnome/shell/extensions/pop-shell" = {
      # https://github.com/pop-os/shell/blob/master_focal/schemas/org.gnome.shell.extensions.pop-shell.gschema.xml
      # https://github.com/pop-os/shell/blob/master_noble/keybindings/10-pop-shell-move.xml
      pop-monitor-down = ["disabled"];
      pop-monitor-left = ["disabled"];
      pop-monitor-right = ["disabled"];
      pop-monitor-up = ["disabled"];

      pop-workspace-down = ["disabled"];
      pop-workspace-left = ["disabled"];
      pop-workspace-right = ["disabled"];
      pop-workspace-up = ["disabled"];
    };
    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = ["disabled"];
      toggle-tiled-right = ["disabled"];
    };
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui=["<Shift><Super>s"];
      toggle-quick-settings = ["disabled"];
    };
    "org/gnome/desktop/wm/keybindings" = {
      minimize = ["<Super>w"];
      activate-window-menu = "disabled";
      toggle-quick-settings = "disabled";
      restore-shortcuts = "disabled";
      #toggle-message-tray = "disabled";
      close = ["<Super>q"];
      #maximize = "disabled";
      move-to-monitor-down = "disabled";
      move-to-monitor-left = "disabled";
      move-to-monitor-right = "disabled";
      move-to-monitor-up = "disabled";
      move-to-workspace-left = ["<Shift><Super>h" "<Shift><Super>k" "<Shift><Super>Left"];
      move-to-workspace-right = ["<Shift><Super>l" "<Shift><Super>j" "<Shift><Super>Right"];
      move-to-workspace-down = "disabled";
      move-to-workspace-up = "disabled";
      switch-to-workspace-left=["<Control><Super>k" "<Control><Super>h" "<Control><Super>Left"];
      switch-to-workspace-right=["<Control><Super>j" "<Control><Super>l" "<Control><Super>Right"];
      #toggle-maximized = ["<Super>m"]';
      #unmaximize = "disabled";
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
        #next = [ "<Shift><Control>n" ];
        #previous = [ "<Shift><Control>p" ];
        #play = [ "<Shift><Control>space" ];
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
        ];
        screensaver=["<Super>Escape"];
      };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "launch terminal";
      command = "kgx";
      binding = "<Super>t";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "launch files";
      command = "nautilus";
      binding = "<Super>f";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "launch browser";
      command = "firefox";
      binding = "<Super>b";
    };
    # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
    #   name = "screenshot";
    #   command = "flameshot gui";
    #   binding = "<Super><Shift>s";
    # };
  };
}
