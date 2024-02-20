{ config, pkgs, ... }:
{
  home.username = "sevi";
  home.homeDirectory = "/home/sevi";

  programs.git = {
    enable = true;
    userName = "Severin Lochschmidt";
    userEmail = "seviron53@gmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
    };
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

  home.shellAliases = {
    rm = "rm -i";
    srm = "srm -i";
    ll = "ls -l";
    ls = "ls --color=tty";
    "..." = "cd ../..";
    btop = "btop -p 0";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
