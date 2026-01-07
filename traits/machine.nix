/*
  Universal hardware configuration options 
*/
{ config, pkgs, lib, ... }:
{
  config = {
    boot.kernelPackages = pkgs.linuxPackages_6_12;
    services.fwupd.enable = true;
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.editor = true;
    boot.initrd.systemd.enable = true;
    boot.initrd.availableKernelModules = [ "hid_cherry" "usbhid" "mac_hid" "hid_generic" "hid" "usbcore" "evdev" ];
    boot.kernel.sysctl = {
      "vm.swappiness" = 10;
    };

    users.mutableUsers = true; # Set passwords after setup

    # Archer tx20u nano dongle 
    # https://phip1611.de/blog/enabling-tp-link-archer-tx20u-nano-on-nixos-and-linux-6-12/
    boot.kernelModules = [ "8852au" ];
    boot.extraModulePackages = [ config.boot.kernelPackages.rtl8852bu ]; # TP-Link Archer TX20U Nano
    services.udev.extraRules =
      # Switch Archer TX20U Nano from CDROM mode (default) to WiFi mode.
      # Also set global hidraw device permissions so hidraw* devices are
      # accessible to users in the plugdev group.
      ''
        ATTR{idVendor}=="0bda", ATTR{idProduct}=="1a2b", RUN+="${lib.getExe pkgs.usb-modeswitch} -K -v 0bda -p 1a2b"
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="plugdev"
      '';

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

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      wireplumber.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    services.pulseaudio.enable = false;
    environment.systemPackages = with pkgs; [
      qpwgraph
    ];

    services.printing.enable = true;
    hardware.sane.enable = true;
  };
}
