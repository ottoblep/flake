# Base graphical programs for headed machines
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    keepassxc
    speedcrunch
    pdftk
    pdfgrep
    pandoc
    drawio
    nil
  ];
}
