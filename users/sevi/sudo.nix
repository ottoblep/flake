{ config, lib, pkgs, ... }:
{
  config.users.users.sevi.extraGroups = [ "wheel" ];
}

