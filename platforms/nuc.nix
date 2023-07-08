{ config, pkgs, lib, modulesPath, ... }:
{
  imports = [
  ];

  config = {
    # TODO check intel nuc hardware conf

    networking.hostName = "tomnuc";

    nixpkgs.overlays = [
      (final: prev: {
      })
    ];
  };
}
