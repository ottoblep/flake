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
      pdfgrep
      zoom-us
      nix-lrz-sync-share.lrz-sync-share
      # TODO sleek
    ];
  };
}

