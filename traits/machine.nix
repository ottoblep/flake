/*
  Universal hardware configuration options 
*/
{ config, pkgs, lib, ... }:
{
  config = {
    boot.kernelPackages = pkgs.linuxPackages_latest;
    services.fwupd.enable = true;
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.editor = true;
    boot.initrd.systemd.enable = true;
    boot.initrd.availableKernelModules = [ "hid_cherry" "usbhid" "mac_hid" "hid_generic" "hid" "usbcore" "evdev" ];

    boot.extraModulePackages = [ ];

    users.mutableUsers = true; # Set passwords after setup

    networking.useDHCP = lib.mkDefault true;
    networking.networkmanager = {
      enable = true;
      wifi.macAddress = "stable-ssid";
      wifi.scanRandMacAddress = true;
    };
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

    # On NixOS 24.05 or older, this option must be set:
    sound.enable = false;

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    hardware.pulseaudio.enable = false;

    services.printing.enable = true;
    hardware.sane.enable = true;
  };
}
