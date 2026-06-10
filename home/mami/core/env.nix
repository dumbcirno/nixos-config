{ ... }:
{
  home.sessionVariables = {
    # Wayland-first; X11 apps fall back via niri + xwayland-satellite
    "NIXOS_OZONE_WL" = "1";
    "ELECTRON_OZONE_PLATFORM_HINT" = "auto";
    "MOZ_ENABLE_WAYLAND" = "1";
    "GDK_BACKEND" = "wayland,x11";
    "QT_QPA_PLATFORM" = "wayland;xcb";
    "SDL_VIDEODRIVER" = "wayland";
    "XDG_SESSION_TYPE" = "wayland";
    "XDG_CURRENT_DESKTOP" = "niri";
    "XCURSOR_SIZE" = "24";
  };
}
