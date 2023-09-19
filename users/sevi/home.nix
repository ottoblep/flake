{ config, pkgs, ... }:
{
  imports = [ ./graphical.nix ./gnome ];

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

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
