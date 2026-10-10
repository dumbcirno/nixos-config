{ pkgs, ... }:
let
  # Same palette as walker / mako
  walker = {
    bg = "#1f1f28";
    bgDim = "#16161d";
    bgRaised = "#2a2a37";
    bgSidebar = "#18181f";
    fg = "#e9eef5";
    accent = "#54546d";
    border = "#3d3d50";
    error = "#C34043";
    errorFg = "#DCD7BA";
  };

  gtkNamedColors = ''
    @define-color accent_color ${walker.accent};
    @define-color accent_bg_color ${walker.accent};
    @define-color accent_fg_color ${walker.fg};
    @define-color destructive_color ${walker.error};
    @define-color destructive_bg_color ${walker.error};
    @define-color destructive_fg_color ${walker.errorFg};
    @define-color error_color ${walker.error};
    @define-color error_bg_color ${walker.error};
    @define-color error_fg_color ${walker.errorFg};
    @define-color window_bg_color ${walker.bg};
    @define-color window_fg_color ${walker.fg};
    @define-color view_bg_color ${walker.bgDim};
    @define-color view_fg_color ${walker.fg};
    @define-color headerbar_bg_color ${walker.bg};
    @define-color headerbar_fg_color ${walker.fg};
    @define-color headerbar_border_color ${walker.border};
    @define-color headerbar_backdrop_color ${walker.bg};
    @define-color headerbar_shade_color rgba(0, 0, 0, 0.36);
    @define-color card_bg_color ${walker.bgRaised};
    @define-color card_fg_color ${walker.fg};
    @define-color popover_bg_color ${walker.bgRaised};
    @define-color popover_fg_color ${walker.fg};
    @define-color dialog_bg_color ${walker.bgRaised};
    @define-color dialog_fg_color ${walker.fg};
    @define-color sidebar_bg_color ${walker.bgSidebar};
    @define-color sidebar_fg_color ${walker.fg};
    @define-color sidebar_backdrop_color ${walker.bgSidebar};
    @define-color sidebar_border_color ${walker.border};
    @define-color shade_color rgba(0, 0, 0, 0.36);
    @define-color scrollbar_outline_color rgba(0, 0, 0, 0.5);

    @define-color theme_bg_color ${walker.bg};
    @define-color theme_fg_color ${walker.fg};
    @define-color theme_base_color ${walker.bgDim};
    @define-color theme_text_color ${walker.fg};
    @define-color theme_selected_bg_color ${walker.accent};
    @define-color theme_selected_fg_color ${walker.fg};
    @define-color insensitive_bg_color ${walker.bg};
    @define-color insensitive_fg_color alpha(${walker.fg}, 0.5);
    @define-color borders ${walker.border};
    @define-color unfocused_borders ${walker.border};
  '';
in
{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.nordic;
    name = "Nordic-cursors";
    size = 16;
  };

  home.sessionVariables.GTK_THEME = "adw-gtk3-dark";

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk3.extraCss = gtkNamedColors;
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
    iconTheme = {
      package = pkgs.nordic;
      name = "Nordic-bluish";
    };

    font = {
      name = "Noto Sans";
      size = 13;
    };

    cursorTheme = {
      package = pkgs.nordic;
      name = "Nordic-cursors";
      size = 16;
    };
  };
}
