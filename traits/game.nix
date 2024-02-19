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
      telegram-desktop
      whatsapp-for-linux
    ];
  };
}


