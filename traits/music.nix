/*
  Programs for music production
*/
{ config, pkgs, lib, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      musescore
      audacity
      zrythm
    ];
  };
}
