{ pkgs, lib, ... }:
{
  # For copying nix stores to a new machine (saving bandwidth) use 'nix-serve'
  # nixos-install --flake github:ottoblep/flake#MACHINE --substituters "http://SERVER_URL:14924?trusted=1 https://cache.nixos.org/" 
  # nixos-rebuild switch --flake github:ottoblep/flake#MACHINE --option substituters "http://SERVER_URL:14924?trusted=1 https://cache.nixos.org/" 

  services.nix-serve = {
    enable = true;
    package = pkgs.nix-serve-ng;
    port = 14924;
    openFirewall = true;
  };
}
