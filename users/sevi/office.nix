# Programs for advanced office use
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    xournalpp
    texliveFull
    libreoffice
  ];
}
