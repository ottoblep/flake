/*
  Base configuration for all accounts 
*/
{ config, pkgs, lib, ... }:
{
  config = {
    time.timeZone = "Europe/Berlin";
    # Windows wants hardware clock in local time instead of UTC
    time.hardwareClockInLocalTime = true;
    console.keyMap = "de";

    environment.systemPackages = with pkgs; [
      # Shell utilities
      vim
      curl
      wget
      git
      git-lfs
      ripgrep
      btop
      fd
      duf
      zoxide
      tree
      p7zip
      srm
      file
      tio
      avahi
      nixpkgs-fmt
      todo-txt-cli
      neofetch
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
