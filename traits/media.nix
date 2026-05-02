/*
  Programs for general Image, Audio and Video Processing
*/
{ config, pkgs, lib, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      pinta
      yt-dlp
      # Audiobooks
      # https://github.com/devnen/Chatterbox-TTS-Server
      # Axel, low temp, exxageration
      unzip
      foliate
      epub2txt2
    ];
  };
}
