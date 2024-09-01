{ config, pkgs, ... }:

{
  imports = [
    #./kgx.nix
    ./firefox.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kuba";
  home.homeDirectory = "/home/kuba";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.gnome.dconf-editor

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kuba/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # based on https://heywoodlh.io/nixos-gnome-settings-and-keyboard-shortcuts
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      document-font-name="Source Sans 3 Ultra-Light 13";
      font-name="Source Sans 3 Ultra-Light 13";
      monospace-font-name="Source Code Pro 13";
      text-scaling-factor = "1.25";
      show-battery-percentage=true;
    };
    "org/gnome/shell" = {
       #enabled-extensions = [
       #  "pop-shell@system76.com"
       #];
       favorite-apps = [
         "firefox.desktop"
         "org.gnome.Console.desktop"
         "code.desktop"
         "org.gnome.Nautilus.desktop"
         "dev.zed.Zed.desktop"
      ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      minimize = "disabled";
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
      move-to-workspace-left = ["<Shift><Super>h" "<Shift><Super>k"];
      move-to-workspace-right = ["<Shift><Super>l" "<Shift><Super>j"];
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
          #"/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
        ];
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
  };
}
