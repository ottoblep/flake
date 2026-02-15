{ config, pkgs, lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  config =
    let
      user-image = ./icons/sevtp2.jpg;
    in
    {
      networking.hostName = "sevtp2";

      boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" ];

      # Set profile images
      system.activationScripts.setUserImages.text = ''
        cp -f ${user-image} /var/lib/AccountsService/icons/sevi
      '';

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

      services.xserver.videoDrivers = [ "amdgpu" ];

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

      environment.systemPackages = with pkgs; [
        tpacpi-bat
      ];

      services.fprintd.enable = true;

      hardware.graphics =
        {
          enable = true;
          enable32Bit = true;
        };

      hardware.amdgpu = {
        opencl.enable = true;
      };

      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      environment.sessionVariables = {
        # Fix for https://gitlab.gnome.org/GNOME/gtk/-/issues/6890
        GSK_RENDERER = "gl";
      };
    };
}

