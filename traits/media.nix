/*
  Programs for Image, Audio and Video Processing
*/
{ config, pkgs, lib, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      shortwave
      vlc
      pinta
      yt-dlp
    ];
  };
}
