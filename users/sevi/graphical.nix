{ pkgs, ... }:
{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
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

  programs.chromium = {
    enable = true;
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock-origin
      "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
      "bkdgflcldnnnapblkhphbgpggdiikppg" # duckduckgo
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
        key = "ctrl+alt+[Backslash]"; # ctrl + alt + #
        command = "workbench.action.terminal.toggleTerminal";
        when = "terminal.active";
      }
      {
        key = "alt+q";
        command = "workbench.action.closeActiveEditor";
      }
      {
        key = "ctrl+shift+[Backslash]"; # ctrl + shift + #
        command = "workbench.action.closeSidebar";
      }
      {
        key = "ctrl+alt+p";
        command = "workbench.action.quickOpen";
      }
      # ctrl+tab to switch tabs 
      # ctrl + 1234 to switch panes
      # ctrl + shift + EFG for sidebar opening
      # ctrl + alt + p to open files
      # ctrl + shift + p for all vscode commands
    ];

    userSettings = {
      "security.workspace.trust.untrustedFiles" = "open";
      "editor.fontSize" = 13;
      "editor.wordWrap" = "on";
      "terminal.integrated.fontSize" = 13;
      "vim.foldfix" = true;
      "vim.useSystemClipboard" = true;
      "editor.minimap.enabled" = false;
      "workbench.colorTheme" = "GitHub Dark";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.startupEditor" = "none";
      "workbench.activityBar.visible" = false;
    };
  };

  programs.alacritty = {
    enable = true;
    settings = import ./dotfiles/alacritty.nix;
  };
}
