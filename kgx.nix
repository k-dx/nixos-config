{ config, pkgs, ... }:
{
  programs.gnome-terminal = {
    enable = true;
    settings = {
      "audible-bell" = false;
    };
  };
}

