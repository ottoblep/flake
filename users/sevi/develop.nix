{ pkgs, ... }:
let
  lrzSnSDesktopItem = pkgs.makeDesktopItem
    {
      name = "lrz-sync-share";
      desktopName = "LRZ Sync and Share";
      exec = "lrz-sync-share";
    };
in
{
  home.packages = with pkgs; [
    mypkgs.lrz-sync-share
    lrzSnSDesktopItem
  ];

  # Autostart File Sync
  home.file.".config/autostart/lrz-sync-share.desktop".source = "${lrzSnSDesktopItem}/share/applications/lrz-sync-share.desktop";

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (ps: with ps;
      [
        gcc
        rustup # Need to 'rustup default stable' manually
        zlib
        openssl.dev
        pkg-config
        lldb
        espup
        probe-rs
      ]);
    extensions = with pkgs.vscode-extensions; [
      mhutchie.git-graph
      vscodevim.vim
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      jnoortheen.nix-ide
      arrterian.nix-env-selector
      james-yu.latex-workshop
      mechatroner.rainbow-csv
      ms-python.python
      ms-python.vscode-pylance
      rust-lang.rust-analyzer
      vadimcn.vscode-lldb
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
      "latex-workshop.view.pdf.spreadMode" = 0; # For dual page
      "latex-workshop.view.pdf.color.dark.pageBorderColor" = "#181926"; # Catppuccin Macchiato
      "latex-workshop.view.pdf.color.dark.backgroundColor" = "#1e2030";
      "latex-workshop.view.pdf.color.dark.pageColorsBackground" = "#24273a";
      "latex-workshop.view.pdf.color.dark.pageColorsForeground" = "#cad3f5";
      "latex-workshop.latex.autoClean.run" = "onBuilt";
    };
  };
}
