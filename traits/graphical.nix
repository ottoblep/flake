/*
  Base programs for headed machines
*/
{ config, pkgs, lib, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      asciiquarium-transparent
      keepassxc
      speedcrunch
      thunderbird
      pdftk
      pdfgrep
      pandoc
      drawio
      nil
      mypkgs.csv-tui
    ];
  };
}
