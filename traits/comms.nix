/*
  Programs for live communication 
*/
{ config, pkgs, lib, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      # Start with and enable screenshare of applications started with XDG_SESSION_TYPE=x11 GDK_BACKEND=x11
      pkgs.zoom-us
      whatsapp-for-linux
      signal-desktop
    ];
  };
}
