/*
  Programs for general Image, Audio and Video Processing
*/
{ config, pkgs, lib, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      pinta
      yt-dlp
    ];
  };
}
