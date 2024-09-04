{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName  = "k-dx";
    userEmail = "tornadowro@gmail.com";
  };
}
