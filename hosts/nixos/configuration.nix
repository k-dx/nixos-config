# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, pkgs-unstable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.consoleMode = "2";
  boot.loader.systemd-boot.configurationLimit = 30;
  boot.loader.timeout = 3;

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # systemd-resolved configuration needed for Mullvad VPN
  # https://nixos.wiki/wiki/Systemd-resolved
  networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    dnsovertls = "true";
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "pl,eu";
    xkb.variant = "";
  };

  # Configure console keymap
  console.keyMap = "pl2";
  console = {
    font = "ter-i32b";
    packages = with pkgs; [ terminus_font ];
    earlySetup = true;
  };
  # boot.earlyVconsoleSetup = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kuba = {
    isNormalUser = true;
    description = "Kuba";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.variables.EDITOR = "vim";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [ # with pkgs; [
    pkgs-unstable.pcloud
    pkgs.texliveFull
    pkgs.blender
    pkgs.jdk
    pkgs.jadx
    pkgs.apktool
    pkgs.distrobox
    pkgs.python3
    pkgs.android-studio
    pkgs.nodejs_22
    pkgs.fira
    #pkgs.anydesk
    #pkgs.starship
    pkgs.trash-cli
    pkgs.google-chrome
    pkgs.freefilesync
    pkgs.spotify
    pkgs.mpv
    #pkgs.peek
    pkgs.pdfarranger
    pkgs.meld
    pkgs.pika-backup
    #pkgs.darktable
    pkgs.discord
    pkgs.flameshot
    pkgs.keepassxc
    pkgs.nnn
    #pkgs.zed-editor
    pkgs.vscode
    pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.pop-shell
    pkgs.gnomeExtensions.workspace-matrix
    pkgs.gnome.gnome-tweaks
    pkgs.pop-launcher
    pkgs.libnotify
    pkgs.zip
    pkgs.unzip
    pkgs.git
    pkgs.stow
    pkgs.helix
    pkgs.neovim
    pkgs.vim-full # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    pkgs.wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    epiphany
  ]);

  services.tailscale.enable = true;
  networking.firewall.checkReversePath = "loose"; # fix exit node

  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  # for distrobox:
  virtualisation.podman = {
    enable = true;
    # dockerCompat = true;
  };
}
