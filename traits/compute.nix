/*
  Programs for data processing
*/
{ config, pkgs, lib, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
        octaveFull
    ];
  };
}

