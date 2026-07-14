# Shared cli packages consumed as both trait and home-manager module
pkgs: with pkgs; [
  vim
  file
  fd
  ikill
  curl
  wget
  git
  git-lfs
  ripgrep
  btop
  tree
  p7zip
  srm
  tio
  fastfetch
  wormhole-william # Large file transfer without ssh
  nixpkgs-fmt
  nix-tree
  nix-search-cli
]
