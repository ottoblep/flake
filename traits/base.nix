/*
  Base configuration for all accounts 
*/
{ config, pkgs, lib, ... }:
{
  config = {
    time.timeZone = "Europe/Berlin";
    time.hardwareClockInLocalTime = true;
    console.keyMap = "de";

    programs.nano.enable = false; # Remove default

    boot.kernelModules = [ "uinput" ];
    services.udev.extraRules = ''
      KERNEL=="uinput", GROUP="uinput", MODE="0660"
    '';
  };
}
