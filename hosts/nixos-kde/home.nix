{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/home-manager/firefox.nix
    #../../modules/home-manager/gnome.nix
    ../../modules/home-manager/git.nix
    inputs.plasma-manager.homeManagerModules.plasma-manager
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


  programs.plasma = {
    enable = true;

    shortcuts = {
      "kwin"."Switch One Desktop Down" = ["Meta+Ctrl+J" "Meta+Ctrl+Down"];
      "kwin"."Switch One Desktop Up" = ["Meta+Ctrl+K" "Meta+Ctrl+Up"];
      "kwin"."Switch One Desktop to the Left" = ["Meta+Ctrl+H" "Meta+Ctrl+Left,Meta+Ctrl+Left,Switch One Desktop to the Left"];
      "kwin"."Switch One Desktop to the Right" = ["Meta+Ctrl+L" "Meta+Ctrl+Right,Meta+Ctrl+Right,Switch One Desktop to the Right"];

      "kwin"."Window One Desktop Down" = ["Meta+Shift+K" "Meta+Ctrl+Shift+Down"];
      "kwin"."Window One Desktop Up" = ["Meta+Shift+K" "Meta+Ctrl+Shift+Up"];
      "kwin"."Window One Desktop to the Left" = ["Meta+Shift+H" "Meta+Ctrl+Shift+Left,Meta+Ctrl+Shift+Left,Window One Desktop to the Left"];
      "kwin"."Window One Desktop to the Right" = ["Meta+Shift+L" "Meta+Ctrl+Shift+Right"];
    };

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      # iconTheme = "Papirus-Dark";
    };

    panels = [
      {
        location = "bottom";
        floating = false;
      }
      # {
      #   location = "left";
      #   floating = false;
      #   lengthMode = "fit";
      #   hiding = "dodgewindows";
      #   widgets = [
      #     "org.kde.plasma.icontasks"
      #   ];
      # }
      # {
      #   location = "top";
      #   floating = false;
      #   height = 22;
      #   widgets = [
      #     "org.kde.plasma.globalmenu"
      #   ];
      # }
    ];

    kwin.virtualDesktops = {
      number = 4;
      rows = 2;
    };

    configFile = {
      "kdeglobals"."KDE"."AnimationDurationFactor" = 0.25;
    };
  };
}
