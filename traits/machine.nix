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

    users.mutableUsers = true; # Set passwords after setup

    powerManagement.cpuFreqGovernor = "ondemand";

    networking.networkmanager.enable = true;
    # networking.wireless.enable = true; # For Network Manager
    # networking.firewall.enable = true;

    sound.enable = true;
    hardware.pulseaudio.enable = true;
  };
}
