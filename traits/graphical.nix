/*
  Programs for headed machines
*/
{ config, pkgs, lib, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      # Graphical Programs
      keepassxc
      speedcrunch
      xournalpp
      thunderbird
      drawio
      nil
      pkgs.unstable.zoom-us
      whatsapp-for-linux
      signal-desktop
      # sleek
    ];
  };
}

