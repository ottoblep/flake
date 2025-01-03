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

  # Build tools and libraries are defined in separate devshells
  # Open vscode vscode inside this dev shell to inherit

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium.fhsWithPackages (ps: with ps; [ ]);
    extensions = with pkgs.vscode-extensions; [
      # General
      mhutchie.git-graph
      vscodevim.vim
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      mechatroner.rainbow-csv
      # Nix
      jnoortheen.nix-ide
      arrterian.nix-env-selector
      # Latex
      james-yu.latex-workshop
      # Python
      ms-python.python
      ms-python.vscode-pylance
      # Rust
      rust-lang.rust-analyzer
      # C++
      twxs.cmake
      ms-vscode.cpptools # Intellisense
      vadimcn.vscode-lldb # LLDB Debug Config
      # cpptools wants include paths in .vscode/c_cpp_properties.json, for example "${CMAKE_INCLUDE_PATH}/**"
      # c_cpp_properties.json can be generated with "C/C++: Edit Configurations (UI)"
      # make sure to build with debug symbols "cmake -DCMAKE_BUILD_TYPE=Debug"
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
      "symbols.hidesExplorerArrows" = false;
    };
  };
}
