{ config, pkgs, lib, modulesPath, ... }:
{
  imports = [
  ];

  config = {
    # TODO check intel nuc hardware conf

    networking.hostName = "nuc";

    nixpkgs.overlays = [
      (final: prev: {
      })
    ];
  };
}
