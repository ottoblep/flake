/*
  A trait for configurations which are most definitely machines
*/
{ pkgs, ... }:

{
  config = {
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.editor = true;
    boot.initrd.systemd.enable = true;

    users.mutableUsers = false;

    powerManagement.cpuFreqGovernor = "ondemand";

    networking.wireless.enable = true; # For Network Manager
    networking.networkmanager.enable = true;
    # networking.firewall.enable = true;

    sound.enable = true;
    hardware.pulseaudio.enable = enable;
  }
}
