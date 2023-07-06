{ config, pkgs, lib, ... }:

{
  config = {
    time.timeZone = "Europe/Berlin";
    # Windows wants hardware clock in local time instead of UTC
    time.hardwareClockInLocalTime = true;

    environment.systemPackages = with pkgs; [
      # Shell utilities
      git
      ripgrep
      htop
      fd
      tree
      file
      tio
    ];

    # Use edge NixOS.
    nix.extraOptions = ''
      experimental-features = nix-command flakes
    '';
    # nix.package = pkgs.nixUnstable;

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    nixpkgs.config.allowUnfree = true;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?
  };
}
