# Baseline CLI tools for a home-manager setup (e.g. standalone on Debian).
# Shares its package list with traits.cli via packages/cli.nix.
{ pkgs, ... }:
{
  home.packages = import ../../packages/cli.nix pkgs;
}
