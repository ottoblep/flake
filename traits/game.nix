/*
  Recreational Programs
*/
{ config, pkgs, lib, ... }:
{
  config = {
    boot.kernelPackages = lib.mkOverride 800 pkgs.linuxKernel.packages.linux_xanmod;

    environment.systemPackages = with pkgs; [
      steam # Comes with working proton
      gamemode # Set steam launch option to activate
      firefox # Sync should set up Catppuccin Macchiato theme for firefox and dark reader 
      scanmem
      ruffle
      lutris
      heroic
      r2modman
    ];

    # Required by heroic 2.18.1
    nixpkgs.config.permittedInsecurePackages = [
      "electron-36.9.5"
    ];

    services.zerotierone.enable = true;
  };
}


