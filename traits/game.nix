/*
  Recreational Programs
*/
{ config, pkgs, lib, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      steam
      firefox
      discord
      whatsapp-for-linux
      signal-desktop
    ];
  };
}


