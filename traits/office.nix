/*
  Programs for office use 
*/
{ config, pkgs, lib, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      texliveFull
      pdftk
      pdfgrep
      pandoc
      libreoffice
    ];
  };
}


