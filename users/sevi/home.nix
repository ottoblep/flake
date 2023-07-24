{ config, pkgs, lib, ... }:

{
  imports = [ ./dconf.nix ];

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

  home.packages = with pkgs; [
    gnomeExtensions.user-themes
    gnomeExtensions.space-bar
    gnomeExtensions.paperwm
    gnomeExtensions.transparent-top-bar
    gnomeExtensions.dash-to-dock
    gnomeExtensions.bing-wallpaper-changer
    alacritty
    keepassxc
    speedcrunch
    xournalpp
    thunderbird
    drawio
    nil
    zoom-us
    # TODO sleek
    # TODO LRZ Sync and Share
  ];

  programs.chromium = {
    enable = true;
    extensions  = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock-origin
      "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
    ];
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs; [
      vscode-extensions.mhutchie.git-graph
      vscode-extensions.vscodevim.vim
      vscode-extensions.github.github-vscode-theme
      vscode-extensions.pkief.material-icon-theme
      vscode-extensions.jnoortheen.nix-ide
    ];

    keybindings = [
      {
        key = "ctrl+[Backquote]";
        command = "workbench.action.terminal.toggleTerminal";
        when = "terminal.active";
      }
      {
        key = "alt+q";
        command = "workbench.action.closeActiveEditor";
      }
      # For switching tabs ctrl+tab is default
      # To launch a new window use the console and 'codium FILE'
      # To switch to a file by name use ctrl+p
    ];

    userSettings = {
      "security.workspace.trust.untrustedFiles" = "open";
      "editor.fontSize" = 13;
      "editor.wordWrap"= "on";
      "terminal.integrated.fontSize" = 13;
      "vim.foldfix" = true;
      "vim.useSystemClipboard" = true;
      "vim.vimrc.enable" = true;
      "editor.minimap.enabled" = false;
      "workbench.colorTheme" = "GitHub Dark";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.startupEditor" = "none";
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

  programs.git = {
    userName  = "Severin Lochschmidt";
    userEmail = "seviron53@gmail.com";
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
