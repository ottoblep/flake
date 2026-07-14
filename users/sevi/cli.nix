{ pkgs, ... }:
{
  home.packages = import ../../packages/cli.nix pkgs;

  home.sessionVariables.EDITOR = "vim";

  services.gpg-agent.enable = true;
}
