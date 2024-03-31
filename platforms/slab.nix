{ config, pkgs, lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  config =
    let
      user-image = ./icons/slab.jpg;
    in
    {
      networking.hostName = "slab";

      # Set profile images
      system.activationScripts.setUserImages.text = ''
        cp -f ${user-image} /var/lib/AccountsService/icons/sevi
      '';

      boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" "ahci" "usb_storage" "sr_mod" ];
      boot.initrd.kernelModules = [ "amdgpu" "btintel" ];
      boot.kernelModules = [ "kvm-amd" ];

      services.xserver.videoDrivers = [ "amdgpu" ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

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

      hardware.opengl = {
        enable = true;
        extraPackages = with pkgs; [
          mesa
          amdvlk
        ];
      };

      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
