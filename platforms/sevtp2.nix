{ config, pkgs, lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  config = {
    # TODO check hardware conf
    networking.hostName = "sevtp2";
  };

  powerManagement.cpuFreqGovernor = "ondemand";
}

