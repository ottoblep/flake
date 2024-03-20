/*
  Virtualization related options
*/
{ pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
  };
}

