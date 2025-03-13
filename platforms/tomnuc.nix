{ config, pkgs, lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  config =
    let
      tomnook-image = ./icons/tomnook.jpg;
    in
    {
      networking.hostName = "tomnuc";
      # Set profile images
      system.activationScripts.setUserImages.text = ''
        cp -f ${tomnook-image} /var/lib/AccountsService/icons/sevi
      '';

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      # Picked from nixos-hardware
      hardware.cpu.intel.updateMicrocode =
        lib.mkDefault config.hardware.enableRedistributableFirmware;

      boot.initrd.kernelModules = [ "i915" ];
      boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" "rtsx_pci_sdmmc" ];
      boot.kernelModules = [ "kvm-intel" ];

      fileSystems."/" =
        {
          device = "/dev/disk/by-label/nixos";
          fsType = "ext4";
        };

      fileSystems."/boot" =
        {
          device = "/dev/disk/by-label/boot";
          fsType = "vfat";
        };

      swapDevices =
        [{ device = "/dev/disk/by-label/swap"; }];

      environment.variables = {
        VDPAU_DRIVER = lib.mkDefault "va_gl";
      };

      hardware.graphics.extraPackages = with pkgs; [
        (if (lib.versionOlder (lib.versions.majorMinor lib.version) "23.11") then vaapiIntel else intel-vaapi-driver)
        libvdpau-va-gl
        intel-media-driver
      ];

      nixpkgs.overlays = [
        (final: prev: { })
      ];
    };
}
