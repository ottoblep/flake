/*
  Universal hardware configuration options 
*/
{ pkgs, lib, ... }:
{
  config = {
    boot.kernelPackages = pkgs.linuxPackages_latest;
    services.fwupd.enable = true;
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.editor = true;
    boot.initrd.systemd.enable = true;
    boot.initrd.availableKernelModules = [ "hid_cherry" "usbhid" "mac_hid" "hid_generic" "hid" "usbcore" "evdev" ];

    users.mutableUsers = true; # Set passwords after setup

    networking.useDHCP = lib.mkDefault true;
    networking.networkmanager.enable = true;
    networking.wireless.userControlled.enable = true;

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 ];
      # allowedUDPPortRanges = [
      #   { from = 4000; to = 4007; }
      #   { from = 8000; to = 8010; }
      # ];
    };
    networking.nftables.enable = true;

    sound.enable = true;
    hardware.pulseaudio.enable = true;

    services.printing.enable = true;
    hardware.sane.enable = true;
  };
}
