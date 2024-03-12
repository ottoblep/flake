/*
  NixOS Setup Options
*/
{ config, pkgs, lib, ... }:
{
  config = {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    # Use edge NixOS.
    nix.extraOptions = ''
      experimental-features = nix-command flakes
    '';
    # nix.package = pkgs.nixUnstable;

    # For copying nix stores to a new machine (saving bandwidth) use 'nix-serve'
    # Mind the firewall and add ignore trusted substituters thus as root
    # nixos-install --flake github:ottoblep/flake#MACHINE --substituters "http://SERVER_URL:PORT?trusted=1 https://cache.nixos.org/" 

    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowBroken = true;

    nix = {
      gc = {
        automatic = true;
        options = "--delete-older-than 3d";
        dates = "weekly";
      };
      optimise.automatic = true;
      settings.auto-optimise-store = true;
    };

    # Only for quick prototyping or proprietary blobs
    # programs.nix-ld = {
    #   enable = true;
    #   libraries = with pkgs; [
    #   ];
    # };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?
  };
}
