/*
  Universal hardware configuration options 
*/
{ pkgs, ... }:
{
  config = {
    boot.kernelPackages = pkgs.linuxPackages_latest;
    services.fwupd.enable = true;
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.editor = true;
    boot.initrd.systemd.enable = true;

    users.mutableUsers = true; # Set passwords after setup

    networking.networkmanager.enable = true;
    networking.wireless.userControlled.enable = true;
    # networking.wireless.enable = true; # For Network Manager
    # networking.firewall.enable = true;

    sound.enable = true;
    hardware.pulseaudio.enable = true;

    services.printing.enable = true;
    hardware.sane.enable = true;
  };
}
