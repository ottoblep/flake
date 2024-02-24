/*
  Laptop specific hardware options
*/
{ pkgs, ... }:
{
  # TODO Add TLP
  # TODO Add distinct dconf for small screens
  powerManagement.cpuFreqGovernor = "ondemand";
}

