{ config, pkgs, lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  config =
    let
      user-image = ./icons/sevtp.jpg;
    in
    {
      networking.hostName = "sevtp";

      # Set profile images
      system.activationScripts.setUserImages.text = ''
        cp -f ${user-image} /var/lib/AccountsService/icons/sevi
      '';

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

      fileSystems."/storage" =
        {
          device = "/dev/disk/by-label/storage";
          fsType = "ext4";
        };

      swapDevices =
        [{ device = "/dev/disk/by-label/swap"; }];
    };
}

