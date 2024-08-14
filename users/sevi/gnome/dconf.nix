# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ pkgs, lib, config, ... }:

with lib.hm.gvariant;

{
  dconf.settings =
    let
      background = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nix-wallpaper-dracula.png";
        hash = "sha256-SykeFJXCzkeaxw06np0QkJCK28e0k30PdY8ZDVcQnh4=";
      };
    in
    {
      "org/gnome/mutter" = {
        experimental-features = [ "scale-monitor-framebuffer" "x11-randr-fractional-scaling" ];
      };

      "org/gnome/desktop/calendar" = {
        show-weekdate = false;
      };

      "org/gnome/desktop/interface" = {
        clock-show-seconds = false;
        clock-show-weekday = true;
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
        show-battery-percentage = true;
        text-scaling-factor = 1.0;
        gtk-theme = "${config.gtk.theme.name}";
        cursor-theme = "graphite-dark";
      };

      "org/gnome/desktop/peripherals/touchpad" = {
        edge-scrolling-enabled = false;
        speed = -7.027027027027022e-2;
        tap-to-click = true;
        two-finger-scrolling-enabled = true;
      };

      "org/gnome/desktop/input-sources" = {
        show-all-sources = false;
        sources = [ (mkTuple [ "xkb" "de" ]) ];
        xkb-options = [ "caps:none" ];
      };

      "org/gnome/desktop/wm/keybindings" = {
        activate-window-menu = [ ];
        begin-move = [ ];
        begin-resize = [ ];
        cycle-panels = [ ];
        cycle-panels-backward = [ ];
        maximize = [ ];
        minimize = [ ];
        move-to-monitor-down = [ ];
        move-to-monitor-left = [ ];
        move-to-monitor-right = [ ];
        move-to-monitor-up = [ ];
        move-to-workspace-1 = [ ];
        move-to-workspace-last = [ ];
        move-to-workspace-left = [ ];
        move-to-workspace-right = [ ];
        panel-run-dialog = [ ];
        switch-applications = [ ];
        switch-applications-backward = [ ];
        switch-panels = [ ];
        switch-panels-backward = [ ];
        switch-to-workspace-1 = [ ];
        switch-to-workspace-last = [ ];
        switch-to-workspace-left = [ ];
        switch-to-workspace-right = [ ];
        switch-windows = [ "<Alt>Tab" ];
        switch-windows-backward = [ "<Shift><Alt>Tab" ];
        toggle-fullscreen = [ "<Super>d" ];
        toggle-maximized = [ ];
        unmaximize = [ ];
      };

      "org/gnome/shell/extensions/paperwm/workspaces" = {
        list = [ "c124eb8f-f8f7-4c93-a3fc-3dca6dfe562e" "108ba727-52d0-4e10-91c3-fcb64248c7ff" "0703f2ab-3993-4b66-b94e-2b0e522b5b63" "0907e1ae-6d98-4a58-b7b5-fd1d0e4ef81e" ];
      };

      # For wallpapers, download any you like, optionally throw them into faerber and place them into Pictures/Wallpapers
      # TODO: automate wallpapers

      "org/gnome/shell/extensions/paperwm/workspaces/c124eb8f-f8f7-4c93-a3fc-3dca6dfe562e" = {
        background = "/home/sevi/Pictures/Wallpapers/wallpaper.png";
        index = 0;
        show-top-bar = false;
      };

      "org/gnome/shell/extensions/paperwm/workspaces/108ba727-52d0-4e10-91c3-fcb64248c7ff" = {
        background = "/home/sevi/Pictures/Wallpapers/wallpaper2.png";
        index = 1;
        show-top-bar = false;
      };

      "org/gnome/shell/extensions/paperwm/workspaces/0703f2ab-3993-4b66-b94e-2b0e522b5b63" = {
        background = "/home/sevi/Pictures/Wallpapers/wallpaper.png";
        index = 2;
        show-top-bar = false;
      };

      "org/gnome/shell/extensions/paperwm/workspaces/0907e1ae-6d98-4a58-b7b5-fd1d0e4ef81e" = {
        background = "/home/sevi/Pictures/Wallpapers/wallpaper2.png";
        index = 3;
        show-top-bar = false;
      };

      "org/gnome/eog/ui" = {
        sidebar = false;
      };

      "org/gnome/nautilus/icon-view" = {
        default-zoom-level = "small";
      };

      "org/gnome/nautilus/list-view" = {
        default-zoom-level = "small";
      };

      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "list-view";
        migrated-gtk-settings = true;
        search-filter-time-type = "last_modified";
        search-view = "list-view";
      };

      "org/gnome/nautilus/window-state" = {
        initial-size = mkTuple [ 945 1193 ];
        maximized = false;
        sidebar-width = 204;
      };

      "org/gnome/evince/default" = {
        continuous = true;
        dual-page = true;
        dual-page-odd-left = true;
        enable-spellchecking = true;
        fullscreen = false;
        inverted-colors = false;
        show-sidebar = false;
        sidebar-page = "thumbnails";
        sidebar-size = 246;
        sizing-mode = "automatic";
        window-ratio = mkTuple [ 1.9833333333333334 1.987037037037037 ];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
        screensaver = [ "<Super>q" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Control><Alt>plus";
        command = "alacritty";
        name = "Launch Shell";
      };

      "org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-extensions = [ ];
        enabled-extensions = [ "unite@hardpixel.eu" "paperwm@paperwm.github.com" "hibernate-status@dromi" "user-theme@gnome-shell-extensions.gcampax.github.com" "just-perfection-desktop@just-perfection" "Rounded_Corners@lennart-k" ];
        favorite-apps = [ ];
      };

      # Just-Perfection hides the Dash and other stuff
      "org/gnome/shell/extensions/just-perfection" = {
        accessibility-menu = false;
        activities-button = false;
        activities-button-icon-monochrome = true;
        animation = 4;
        app-menu = false;
        background-menu = true;
        calendar = true;
        clock-menu = true;
        clock-menu-position = 2;
        controls-manager-spacing-size = 0;
        dash = false;
        double-super-to-appgrid = true;
        overlay-key = true;
        events-button = false;
        panel = false;
        panel-in-overview = true;
        panel-notification-icon = true;
        power-icon = true;
        quick-settings = true;
        ripple-box = false;
        search = true;
        show-apps-button = false;
        startup-status = 0;
        theme = false;
        top-panel-position = 0;
        panel-icon-size = 18;
        type-to-search = true;
        weather = true;
        window-demands-attention-focus = true;
        window-picker-icon = false;
        window-preview-caption = true;
        window-preview-close-button = true;
        workspace = false;
        workspace-peek = false;
        workspace-popup = false;
        workspace-switcher-should-show = false;
        workspace-wrap-around = false;
        workspaces-in-app-grid = false;
        world-clock = false;
      };

      # Unite hides window panel bars
      "org/gnome/shell/extensions/unite" = {
        hide-window-titlebars = "always";
      };

      "org/gnome/shell/extensions/user-theme" = {
        name = "${config.gtk.theme.name}";
      };

      # Due to PaperWM this background is only drawn in the overview screen
      "org/gnome/desktop/background" = {
        picture-uri-dark = "${background}";
        # picture-options = "spanned";
      };

      "org/gnome/shell/extensions/hibernate-status-button" = {
        hibernate-works-check = false;
      };

      "org/gnome/shell/extensions/hidetopbar" = {
        mouse-sensitive = true;
      };

      "org/gnome/shell/extensions/paperwm" = {
        has-installed-config-template = true;
        default-focus-mode = 0;
        horizontal-margin = 8;
        minimap-scale = 0.10;
        show-window-position-bar = false;
        tiling-edge-margin = 3;
        topbar-follow-focus = false;
        use-default-background = false;
        vertical-margin = 5;
        vertical-margin-bottom = 5;
        window-gap = 10;
        winprops = [ ];
      };

      "org/gnome/shell/extensions/paperwm/keybindings" = {
        live-alt-tab = [ "" ];
        live-alt-tab-backward = [ "" ];
        move-down = [ "<Control><Super>j" ];
        move-left = [ "<Control><Super>h" ];
        move-monitor-above = [ "<Shift><Control><Super>k" ];
        move-monitor-below = [ "<Shift><Control><Super>j" ];
        move-monitor-left = [ "<Shift><Control><Super>h" ];
        move-monitor-right = [ "<Shift><Control><Super>l" ];
        move-right = [ "<Control><Super>l" ];
        move-up = [ "<Control><Super>k" ];
        switch-down = [ "<Super>j" ];
        switch-first = [ "" ];
        switch-last = [ "" ];
        switch-left = [ "<Super>h" ];
        switch-monitor-above = [ "<Shift><Super>k" ];
        switch-monitor-below = [ "<Shift><Super>j" ];
        switch-monitor-left = [ "<Shift><Super>h" ];
        switch-monitor-right = [ "<Shift><Super>l" ];
        switch-right = [ "<Super>l" ];
        switch-up = [ "<Super>k" ];
      };

      "org/gnome/shell/keybindings" = {
        focus-active-notification = [ ];
        open-application-menu = [ ];
        toggle-application-view = [ ];
        toggle-message-tray = [ ];
        toggle-overview = [ ];
      };

      "org/gnome/shell/weather" = {
        automatic-location = true;
      };
    };
}
