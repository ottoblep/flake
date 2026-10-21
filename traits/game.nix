/*
  Recreational Programs
*/
{ config, pkgs, lib, ... }:
{
  config = {
    boot.kernelPackages = lib.mkOverride 800 pkgs.linuxKernel.packages.linux_xanmod;

    environment.systemPackages = with pkgs; [
      gamemode # Set steam launch option to activate
      firefox # Sync should set up Catppuccin Macchiato theme for firefox and dark reader 
      scanmem
      ruffle
      lutris
      heroic
      r2modman
      bottles
    ];

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Opens ports for Steam Link / Remote Play
      dedicatedServer.openFirewall = true; # Open ports for dedicated server discovery
    };

    programs.alvr = {
      enable = true;
      openFirewall = true;
    };

    # Required by heroic 2.18.1
    nixpkgs.config.permittedInsecurePackages = [
      "electron-36.9.5"
    ];

    services.zerotierone.enable = true;
  };
}


