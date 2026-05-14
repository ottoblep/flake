{ config, pkgs, lib, ... }:
{
  imports = [
    ../services/probe-rs.nix
  ];

  config = {
    hardware.probe-rs.enable = true;

    # Create udev group
    hardware.hackrf.enable = true;
  };
}
