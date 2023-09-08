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

    users.users.sevi = {
      isNormalUser = true;
      home = "/home/sevi";
      createHome = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDpZOwdinQQ8yxfbfe0fASggxkvOdC3dETtxcP2AGbY1DxdVX8EijGSvORN+FIf+JZlS9bvg48UWZOLYHVbWyVnv9M5bPgK8OKgjD/HT5oiIXtCJKtFveroZyc8L9cOadZRBGYoOQrRfMKAnUC1wp1aw5gSAIC5+JPrb+OjKoRwXYwRv+mtXQw+E6DO8nAsVZ8B7u+NyHwYF7uSR+Gl8hbaBriiGlSe0gqIxGNq7CafYZ9uR2wbVZRX8k+mga7gHogY1KaCUmagNG3jDd/d/NIobzO0FJBbPg5J01dGfSOg0EljAlxywLxCERwbtNakHAgsq9qenBgc4wIgiKz/LqmV Sevis SSH Key"
      ];
    };

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


