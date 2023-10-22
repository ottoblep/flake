{ config, pkgs, lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  config = {
    networking.hostName = "slab";

    boot.initrd.kernelModules = [ "amdgpu" ];

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

    hardware.opengl = {
      enable = true;
      extraPackages = with pkgs; [
        mesa
      amdvlk
      ];
    };

  };
}
