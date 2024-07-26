/*
  Programs for advanced office use 
*/
{ config, pkgs, lib, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      xournalpp
      texliveFull
      libreoffice
    ];
  };
}
