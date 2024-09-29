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

    services.pipewire.extraConfig.jack = {
        "20-lower-latency" = {
          "jack.properties" = {
            "rt.prio" = 90;
            "node.latency" = "192/48000";
          };
        };
      };
  };
}
