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
      pinta
      pandoc
      nix-lrz-sync-share.lrz-sync-share
      zerotierone
      # TODO sleek
      # TODO pdf tool (maybe pdftk)
    ];
  };
}

