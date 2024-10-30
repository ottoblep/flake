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
      hydrogen
    ];

    boot.kernelPackages = lib.mkOverride 900 pkgs.linuxKernel.packages.linux_rt_6_1;

    services.pipewire.extraConfig.jack = {
      "20-lower-latency" = {
        "jack.properties" = {
          "rt.prio" = 100;
          "node.latency" = "256/48000";
          "node.lock-quantum" = true;
          "node.force-quantum" = 256;
        };
      };
    };
  };
}
