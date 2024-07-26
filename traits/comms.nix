/*
  Programs for live communication 
*/
{ config, pkgs, lib, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      pkgs.unstable.zoom-us
      whatsapp-for-linux
      signal-desktop
    ];
  };
}
