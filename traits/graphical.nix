/*
  Base programs for headed machines
*/
{ config, pkgs, lib, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      keepassxc
      speedcrunch
      pdftk
      pdfgrep
      pandoc
      drawio
      nil
    ];
  };
}
