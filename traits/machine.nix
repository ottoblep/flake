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

    powerManagement.cpuFreqGovernor = "ondemand";

    networking.networkmanager.enable = true;
    # networking.wireless.enable = true; # For Network Manager
    # networking.firewall.enable = true;

    sound.enable = true;
    hardware.pulseaudio.enable = true;

    hardware.opengl.enable = true;
    hardware.opengl.driSupport = true;
    hardware.opengl.extraPackages = with pkgs; [ libvdpau vdpauinfo libvdpau-va-gl ];

    services.printing.enable = true;
    hardware.sane.enable = true;
  };
}
