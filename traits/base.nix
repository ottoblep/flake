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
      todo-txt-cli
      neofetch
      wormhole-william # Large file transfer without ssh
      trickle # Bandwidth limiting
    ];

    programs.nano.enable = false; # Remove default
  };
}
