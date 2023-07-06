{ config, pkgs, lib, ... }:

{
  home.username = "sevi";
  home.homeDirectory = "/home/sevi";

  programs.git = {
    enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  # TODO set theme and icons
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "palenight";
      package = pkgs.palenight-theme;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  # TODO update dconf / use dconf2nix

  # TODO set correct extensions
  home.packages = with pkgs; [
    gnomeExtensions.user-themes
    gnomeExtensions.space-bar
    fix-vscode
  ] ++ (if stdenv.isx86_64 then [
    # kicad
    chromium
  ]);

  # TODO set vscode config
  # TODO add vscode extensions
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
    };
   ohMyZsh = {
      enable = true;
      plugins = [ "git" "fd" "zoxide" "ripgrep" ];
      theme = "gozilla";
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
