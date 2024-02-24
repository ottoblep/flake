/*
  Non-Laptop specific hardware options
*/
{ pkgs, ... }:
{
  powerManagement.cpuFreqGovernor = "performance";
}
