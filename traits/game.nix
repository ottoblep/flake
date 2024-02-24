/*
  Recreational Programs
*/
{ config, pkgs, lib, ... }:
{
  config = {
    boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_xanmod_latest;

    environment.systemPackages = with pkgs; [
      steam
      gamemode
      firefox
      discord
    ];
  };
}


