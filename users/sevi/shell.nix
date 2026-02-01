{ config, pkgs, ... }:
{
  home.username = "sevi";
  home.homeDirectory = "/home/sevi";

  home.file.".oh-my-zsh/custom/themes/catppuccin.zsh-theme".source = ./dotfiles/catppuccin.zsh-theme;
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "zoxide" ];
      theme = "catppuccin";
    };
    # Add nr helper: nr <pkg> [args...] => nix run nixpkgs#<pkg> -- [args...]
    initContent = ''
      export ZSH_CUSTOM="${config.home.homeDirectory}/.oh-my-zsh/custom"
      nr() {
        if [ $# -lt 1 ]; then
          echo "Usage: nr <package> [args...]" >&2
          return 1
        fi
        local pkg="$1"
        shift
        if [ $# -gt 0 ]; then
          nix run "nixpkgs#$pkg" -- "$@"
        else
          nix run "nixpkgs#$pkg"
        fi
      }
    '';
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
    syncbisync = "rclone bisync --resync ~/sync gdrive-crypt:/ -v";
    syncpush = "rclone sync ~/sync gdrive-crypt:/ -v";
    syncpull = "rclone sync gdrive-crypt:/ ~/sync -v";
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
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
