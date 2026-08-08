{ config, lib, pkgs, ... }:
let
  glass = {
    fg = "#e9eef5";
    bg = "#000000";
    pane = "#000000";
    sidebar = "#0b0f14";
    elevated = "#0d141d";
    border = "rgba(255, 255, 255, 0.12)";
    hover = "rgba(255, 255, 255, 0.06)";
    button = "rgba(255, 255, 255, 0.08)";
    buttonHover = "rgba(255, 255, 255, 0.14)";
    accent = "#2aabee";
    accentFg = "#000000";
    selection = "#0d141d";
  };

  gtk4Css = ''
    :root {
      --window-bg-color: ${glass.bg};
      --window-fg-color: ${glass.fg};
      --view-bg-color: ${glass.pane};
      --view-fg-color: ${glass.fg};
      --headerbar-bg-color: ${glass.bg};
      --headerbar-fg-color: ${glass.fg};
      --headerbar-backdrop-color: ${glass.bg};
      --headerbar-border-color: ${glass.border};
      --sidebar-bg-color: ${glass.sidebar};
      --sidebar-fg-color: ${glass.fg};
      --sidebar-backdrop-color: ${glass.sidebar};
      --sidebar-border-color: ${glass.border};
      --secondary-sidebar-bg-color: ${glass.sidebar};
      --secondary-sidebar-backdrop-color: ${glass.sidebar};
      --accent-bg-color: ${glass.accent};
      --accent-fg-color: ${glass.accentFg};
      --popover-bg-color: ${glass.elevated};
      --popover-fg-color: ${glass.fg};
      --card-bg-color: ${glass.sidebar};
      --card-fg-color: ${glass.fg};
      --dialog-bg-color: ${glass.elevated};
      --dialog-fg-color: ${glass.fg};
      --active-toggle-bg-color: ${glass.buttonHover};
      --active-toggle-fg-color: ${glass.fg};
    }

    window {
      background-color: ${glass.bg};
      color: ${glass.fg};
    }

    headerbar,
    .titlebar {
      background-color: ${glass.bg};
      color: ${glass.fg};
      border-bottom: 1px solid ${glass.border};
      box-shadow: none;
    }

    headerbar:backdrop,
    .titlebar:backdrop {
      background-color: ${glass.bg};
      color: ${glass.fg};
    }

    .nautilus-window {
      background-color: ${glass.bg};
    }

    .nautilus-window .content-pane,
    .nautilus-window .sidebar-pane {
      background-color: ${glass.pane};
    }

    .nautilus-window .sidebar-pane {
      background-color: ${glass.sidebar};
      border-right: 1px solid ${glass.border};
    }

    .nautilus-window:backdrop .content-pane,
    .nautilus-window:backdrop .sidebar-pane {
      background-color: ${glass.pane};
    }

    .nautilus-window:backdrop .sidebar-pane {
      background-color: ${glass.sidebar};
    }

    .nautilus-window .nautilus-list-view,
    .nautilus-window .nautilus-grid-view {
      background-color: ${glass.pane};
      color: ${glass.fg};
    }

    .nautilus-window row:selected {
      background-color: ${glass.selection};
      color: ${glass.fg};
    }

    .nautilus-window row:hover:not(:selected) {
      background-color: ${glass.hover};
    }

    .nautilus-window button {
      background-color: ${glass.button};
      border: 1px solid ${glass.border};
      color: ${glass.fg};
    }

    .nautilus-window button:hover {
      background-color: ${glass.buttonHover};
    }

    .nautilus-window button:checked,
    .nautilus-window button.suggested-action {
      background-color: ${glass.accent};
      color: ${glass.accentFg};
    }

    .nautilus-window entry {
      background-color: ${glass.button};
      border: 1px solid ${glass.border};
      color: ${glass.fg};
    }

    popover,
    popover contents,
    popover.background {
      background-color: ${glass.elevated};
      color: ${glass.fg};
      border: 1px solid ${glass.border};
    }

    scrollbar slider {
      background-color: ${glass.buttonHover};
    }
  '';
in
{
  home.packages = with pkgs; [
    nautilus
  ];

  dconf.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # Own gtk-4.0 outright so a stale Breeze/manual theme cannot override HM.
  xdg.configFile."gtk-4.0/gtk.css" = lib.mkForce {
    force = true;
    text = gtk4Css;
  };

  xdg.configFile."gtk-4.0/settings.ini" = lib.mkForce {
    force = true;
    text = ''
      [Settings]
      gtk-application-prefer-dark-theme=1
      gtk-cursor-theme-name=Nordic-cursors
      gtk-cursor-theme-size=16
      gtk-font-name=Noto Sans 13
      gtk-icon-theme-name=Nordic-bluish
      gtk-theme-name=Adwaita

      [AdwStyleManager]
      color-scheme=prefer-dark
    '';
  };

  xdg.configFile."gtk-4.0/.libadwaita" = lib.mkForce {
    force = true;
    text = "";
  };

  home.activation.removeStaleGtk4Theme = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD rm -f \
      "${config.xdg.configHome}/gtk-4.0/colors.css" \
      "${config.xdg.configHome}/gtk-4.0/window_decorations.css"
    $DRY_RUN_CMD rm -rf "${config.xdg.configHome}/gtk-4.0/assets"
  '';
}
