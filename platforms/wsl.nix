{ config, pkgs, lib, modulesPath, ... }:
{
  config = {
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    fileSystems."/" =
      {
        device = "/dev/sda1";
        fsType = "ext4";
      };

    boot.loader.grub.device = "nodev";

    wsl = {
      enable = true;
      wslConf.automount.root = "/mnt";
      defaultUser = "sevi";
      startMenuLaunchers = true;
    };

    services.vscode-server = {
      enable = true;
      nodejsPackage = pkgs.nodejs_18;
    };
  };
}


