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
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "cmpdlhmnmjhihmcfnigoememnffkimlk" # Catppuccin Macchiato
    ];
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs; [
      vscode-extensions.mhutchie.git-graph
      vscode-extensions.vscodevim.vim
      vscode-extensions.catppuccin.catppuccin-vsc
      vscode-extensions.catppuccin.catppuccin-vsc-icons
      vscode-extensions.jnoortheen.nix-ide
      vscode-extensions.arrterian.nix-env-selector
      vscode-extensions.james-yu.latex-workshop
      vscode-extensions.mechatroner.rainbow-csv
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
      {
        key = "ctrl+shift+e";
        command = "-workbench.action.quickOpenNavigatePreviousInFilePicker";
      }
      # ctrl+tab to switch tabs 
      # ctrl + 1234 to switch panes
      # ctrl + shift + EFG for sidebar opening
      # ctrl + alt + p to open files
      # ctrl + shift + p for all vscode commands
    ];

    userSettings = {
      "security.workspace.trust.untrustedFiles" = "open";
      "window.menuBarVisibility" = "toggle";
      "window.titleBarStyle" = "custom";
      "editor.fontSize" = 13;
      "editor.wordWrap" = "on";
      "terminal.integrated.fontSize" = 13;
      "vim.foldfix" = true;
      "vim.useSystemClipboard" = true;
      "editor.minimap.enabled" = false;
      "workbench.colorTheme" = "Catppuccin Macchiato";
      "workbench.iconTheme" = "catppuccin-macchiato";
      "workbench.startupEditor" = "none";
      "workbench.activityBar.location" = "hidden";
      "latex-workshop.view.pdf.spreadMode" = 1;
      "latex-workshop.view.pdf.color.dark.pageBorderColor" = "#181926"; # Catppuccin Macchiato
      "latex-workshop.view.pdf.color.dark.backgroundColor" = "#1e2030";
      "latex-workshop.view.pdf.color.dark.pageColorsBackground" = "#24273a";
      "latex-workshop.view.pdf.color.dark.pageColorsForeground" = "#cad3f5";
    };
  };

  programs.alacritty = {
    enable = true;
    package = pkgs.unstable.alacritty;
  };
  # Can't yet use the builtin parser because it produces yaml
  home.file.".config/alacritty/alacritty.toml".source = ./dotfiles/alacritty.toml;
  home.file.".config/alacritty/catppuccin-macchiato.toml".source =
    let
      src = pkgs.fetchFromGitHub {
        repo = "alacritty";
        owner = "catppuccin";
        rev = "071d73effddac392d5b9b8cd5b4b527a6cf289f9";
        hash = "sha256-HiIYxTlif5Lbl9BAvPsnXp8WAexL8YuohMDd/eCJVQ8=";
      };
    in
    "${src}/catppuccin-macchiato.toml";

  home.file.".config/openrazer/persistence.conf".source = ./dotfiles/openrazer.conf;
  home.file.".config/xournalpp/settings.xml".source = ./dotfiles/xournalpp.xml;
}
