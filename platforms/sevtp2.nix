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

    };
}

