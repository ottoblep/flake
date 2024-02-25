/*
  Recreational Programs
*/
{ config, pkgs, lib, ... }:
{
  config = {
    boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_xanmod_latest;

    environment.systemPackages = with pkgs; [
      steam # Comes with working proton
      gamemode # Set steam launch option to activate
      firefox # Use Catppuccin Macchiato theme
      discord
    ];
  };
}


