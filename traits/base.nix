/*
  Base configuration for all accounts 
*/
{ config, pkgs, lib, ... }:
{
  time.timeZone = "Europe/Berlin";
  time.hardwareClockInLocalTime = true;

  catppuccin.flavour = "macchiato";

  console = {
    keyMap = "de";
    catppuccin.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Shell utilities
    neovim
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
    todo-txt-cli
    neofetch
    wormhole-william # Large file transfer without ssh
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
}
