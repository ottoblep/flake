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

  home.packages = with pkgs; [
    gnomeExtensions.user-themes
    gnomeExtensions.space-bar
    gnomeExtensions.paperwm
    gnomeExtensions.transparent-top-bar
    gnomeExtensions.dash-to-dock
    gnomeExtensions.bing-wallpaper-changer
    fix-vscode
    keepassxc
    speedcrunch
    xournalpp
    thunderbird
    alacritty
    drawio
    nil
    # TODO sleek
    # TODO LRZ Sync and Share
  ];

  programs.chromium = {
    enable = true;
    extensions  = [
      # TODO add extensions 
    ];
  };

  # TODO set vscode config
  programs.vscode = {
    enable = true;
    extensions = with pkgs; [
      vscode-extensions.mhutchie.git-graph
      vscode-extensions.vscodevim.vim
      vscode-extensions.github.github-vscode-theme
      vscode-extensions.pkief.material-icon-theme
      vscode-extensions.jnoortheen.nix-ide
    ];
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
