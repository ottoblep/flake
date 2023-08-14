{ config, pkgs, lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  config = {
    networking.hostName = "sevtp";

    networking.useDHCP = lib.mkDefault true;

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

    nixpkgs.overlays = [
      (final: prev: { })
    ];
  };
}

