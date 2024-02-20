{ config, pkgs, lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  config =
    let
      slab-image = ./icons/slab.jpeg;
    in
    {
      # Set profile images
      system.activationScripts.setUserImages.text = ''
        cp -f ${slab-image} /var/lib/AccountsService/icons/sevi
      '';
      networking.hostName = "slab";

      powerManagement.cpuFreqGovernor = "performance";

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
