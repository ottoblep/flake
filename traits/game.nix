/*
  Recreational Programs
*/
{ config, pkgs, lib, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      steam
      gamemode
      firefox
      discord
      whatsapp-for-linux
      signal-desktop
    ];
  };
}


