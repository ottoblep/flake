/*
  Programs for music production
*/
{ config, pkgs, lib, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      audacity
      zrythm
      # Use pipewire emulated jack as audio driver
      show-midi
      carla
    ];

    boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_rt_6_1;
  };
}
