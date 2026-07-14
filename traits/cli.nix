# Baseline CLI tools at system level, for hosts without a home-manager setup.
# Shares its package list with homeModules.cli via packages/cli.nix.
{ pkgs, ... }:
{
  environment.systemPackages = import ../packages/cli.nix pkgs;
}
