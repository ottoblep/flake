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
      zoom-us
      pinta
      zerotierone
      whatsapp-for-linux
      signal-desktop
      shortwave
      sleek
    ];
  };
}

