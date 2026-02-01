{ config, pkgs, lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/sd-card/sd-image-aarch64.nix")
  ];

  networking = {
    hostName = "pihole";
    domain = "pihole.local";
    wireless = {
      enable = true;
      networks = {
      };
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [ ]; # ssh and avahi are opened automatically
    };
  };

  # Enable serial console on pins 8,10
  boot.kernelParams = lib.mkOverride 0 [ "console=ttyS1,115200" "console=tty1" ];
  nix.extraOptions = ''experimental-features = nix-command flakes'';
}
