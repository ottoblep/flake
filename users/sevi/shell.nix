{ config, pkgs, ... }:
{
  home.username = "sevi";
  home.homeDirectory = "/home/sevi";

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "fd" "zoxide" "ripgrep" ];
      theme = "gozilla";
    };
  };

  home.file.".config/btop/btop.conf".source = ./dotfiles/btop.conf;
  home.file.".config/btop/themes".source =
    let
      src = pkgs.fetchFromGitHub {
        repo = "btop";
        owner = "catppuccin";
        rev = "1.0.0";
        hash = "sha256-J3UezOQMDdxpflGax0rGBF/XMiKqdqZXuX4KMVGTxFk=";
      };
    in
    "${src}/themes";
  home.file.".vim/".source =
    let
      src = pkgs.fetchFromGitHub {
        repo = "vim";
        owner = "catppuccin";
        rev = "be4725cfc3fb6ed96f706d9d1bd5baa24d2b048c";
        hash = "sha256-Z3ZfpmMrnKugOhu8cuGZGMM8hVy0GpaOfuGNyQBkGdY=";
      };
    in
    "${src}/";
  home.file.".vimrc".source = ./dotfiles/.vimrc;

  home.shellAliases = {
    cd = "z";
    rm = "rm -i";
    srm = "srm -i";
    ls = "eza";
    ll = "eza -l";
    "..." = "cd ../..";
    top = "btop -p 0";
    btop = "btop -p 0";
    df = "duf";
    restartwm = "gnome-extensions reset paperwm@paperwm.github.com; gnome-extensions enable paperwm@paperwm.github.com";
    nixformatall = "nixpkgs-fmt **/*.nix";
    synclog = "journalctl --user -u rclone-bisync.service -b";
    syncloglive = "journalctl --user -u rclone-bisync.service -f";
    syncresync = "rclone bisync --resync ~/sync gdrive-crypt:/ -v";
    syncstart = "systemctl --user start rclone-bisync.service";
    cr = "crush && rm -rf .crush";
  };

  home.packages = with pkgs; [
    zoxide
    eza
    duf
    srm
    btop
    unstable.csv-tui
    crush_custom # LLM Agent doing stuff in the terminal
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
