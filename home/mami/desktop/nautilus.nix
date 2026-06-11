{ pkgs, ... }:
let
  glass = {
    fg = "#e9eef5";
    bg = "rgba(0, 0, 0, 0.58)";
    pane = "rgba(0, 0, 0, 0.45)";
    sidebar = "rgba(0, 0, 0, 0.35)";
    selection = "rgba(13, 20, 29, 0.70)";
    border = "rgba(255, 255, 255, 0.12)";
    borderTop = "rgba(255, 255, 255, 0.18)";
    hover = "rgba(255, 255, 255, 0.06)";
    button = "rgba(255, 255, 255, 0.08)";
    buttonHover = "rgba(255, 255, 255, 0.14)";
    accent = "rgba(42, 171, 238, 0.35)";
    popover = "rgba(13, 20, 29, 0.95)";
    scrollbar = "rgba(255, 255, 255, 0.18)";
  };
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

  xdg.configFile = {
    "gtk-4.0/settings.ini".text = ''
      [AdwStyleManager]
      color-scheme=prefer-dark
    '';

    "gtk-4.0/gtk.css".text = ''
      :root {
        --window-bg-color: ${glass.bg};
        --window-fg-color: ${glass.fg};
        --sidebar-bg-color: ${glass.sidebar};
        --sidebar-border-color: ${glass.border};
        --view-bg-color: ${glass.pane};
        --accent-bg-color: #2aabee;
        --accent-fg-color: #000000;
      }

      window {
        background-color: ${glass.bg};
        color: ${glass.fg};
      }

      .nautilus-window {
        background-color: transparent;
      }

      .nautilus-window .content-pane,
      .nautilus-window .sidebar-pane {
        background-color: ${glass.pane};
      }

      .nautilus-window headerbar {
        background-color: ${glass.pane};
        border-bottom: 1px solid ${glass.border};
        box-shadow: none;
      }

      .nautilus-window .nautilus-list-view,
      .nautilus-window .nautilus-grid-view {
        background-color: transparent;
        color: ${glass.fg};
      }

      .nautilus-window .sidebar {
        background-color: ${glass.sidebar};
        border-right: 1px solid ${glass.border};
      }

      .nautilus-window row:selected {
        background-color: ${glass.selection};
        color: ${glass.fg};
      }

      .nautilus-window row:hover:not(:selected) {
        background-color: ${glass.hover};
      }

      .nautilus-window .sidebar row:selected {
        background-color: ${glass.selection};
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
        color: ${glass.fg};
      }

      .nautilus-window entry {
        background-color: ${glass.button};
        border: 1px solid ${glass.border};
        color: ${glass.fg};
      }

      popover,
      popover contents,
      popover.background {
        background-color: ${glass.popover};
        color: ${glass.fg};
        border: 1px solid ${glass.border};
        opacity: 1;
      }

      scrollbar slider {
        background-color: ${glass.scrollbar};
      }
    '';
  };
}
