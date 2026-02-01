{ pkgs, lib, ... }:
{
  system.autoUpgrade = {
    enable = true;
    dates = "monthly";
    flake = "github:ottoblep/flake";
    allowReboot = true;
    runGarbageCollection = true;
    rebootWindow = {
      lower = "03:00";
      upper = "05:00";
    };
  };
}

