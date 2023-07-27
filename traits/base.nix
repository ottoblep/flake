/*
  Base configuration for all accounts 
*/
{ config, pkgs, lib, ... }:
{
  config = {
    time.timeZone = "Europe/Berlin";
    # Windows wants hardware clock in local time instead of UTC
    time.hardwareClockInLocalTime = true;

    environment.systemPackages = with pkgs; [
      # Shell utilities
      vim
      curl
      gitMinimal
      ripgrep
      pdfgrep
      htop
      fd
      zoxide
      tree
      p7zip
      srm
      file
      tio
      avahi
      nixpkgs-fmt
    ];

  };
}
