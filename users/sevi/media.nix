# Programs for general Image, Audio and Video Processing
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pinta
    yt-dlp
    unzip
    foliate
    epub2txt2
  ];
}
