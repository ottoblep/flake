{ config, pkgs, lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    <nixos-hardware/lenovo/thinkpad/x220>
    ./hardware-configuration.nix
  ];

  config = {
    # TODO check hardware conf
    networking.hostName = "sevtp";

  };

  hardware.trackpoint.enable = true;
  hardware.bluetooth.enable = true;

  # TODO add fingerprint scanner
}

