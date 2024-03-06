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

    programs.nano.enable = false; # Remove default

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
