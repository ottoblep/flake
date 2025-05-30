/*
  Base configuration for all accounts 
*/
{ config, pkgs, lib, ... }:
{
  config = {
    time.timeZone = "Europe/Berlin";
    time.hardwareClockInLocalTime = true;
    console.keyMap = "de";

    environment.systemPackages = with pkgs; [
      # Shell utilities
      vim
      file
      fd
      ikill
      curl
      wget
      git
      git-lfs
      ripgrep
      btop
      tree
      p7zip
      srm
      tio
      neofetch
      trickle # Bandwidth limiting
      wormhole-william # Large file transfer without ssh
    ];

    programs.gnupg.agent.enable = true;

    programs.nano.enable = false; # Remove default
  };
}
