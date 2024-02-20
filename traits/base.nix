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
      wget
      gitMinimal
      ripgrep
      pdfgrep
      btop
      fd
      zoxide
      tree
      p7zip
      srm
      file
      tio
      avahi
      nixpkgs-fmt
      todo-txt-cli
    ];

    services.avahi = {
      nssmdns = true;
      enable = true;
      publish = {
        enable = true;
        domain = true;
        addresses = true;
      };
    };
  };
}
