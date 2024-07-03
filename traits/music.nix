/*
  Programs for Music Processing
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
