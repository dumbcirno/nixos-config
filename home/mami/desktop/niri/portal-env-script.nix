pkgs:
pkgs.writeShellScript "niri-export-portal-env" ''
  set -eu

  export XDG_CURRENT_DESKTOP=niri
  export XDG_SESSION_TYPE=wayland

  # spawn-at-startup inherits niri's env; systemd reads it from the compositor.
  if [ -z "''${WAYLAND_DISPLAY:-}" ]; then
    niri_pid=$(${pkgs.procps}/bin/pgrep -x niri 2>/dev/null | ${pkgs.coreutils}/bin/head -n1 || true)
    if [ -n "$niri_pid" ] && [ -r "/proc/$niri_pid/environ" ]; then
      while IFS= read -r line; do
        case "$line" in
          WAYLAND_DISPLAY=*|DISPLAY=*|NIRI_SOCKET=*)
            export "$line"
            ;;
        esac
      done < <(tr '\0' '\n' < "/proc/$niri_pid/environ")
    fi
  fi

  if [ -z "''${WAYLAND_DISPLAY:-}" ]; then
    echo "niri-export-portal-env: WAYLAND_DISPLAY is not set yet" >&2
    exit 1
  fi

  ${pkgs.systemd}/bin/systemctl --user import-environment \
    WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE NIRI_SOCKET \
    MOZ_ENABLE_WAYLAND NIXOS_OZONE_WL QT_QPA_PLATFORM ELECTRON_OZONE_PLATFORM_HINT

  ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd \
    WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE NIRI_SOCKET \
    MOZ_ENABLE_WAYLAND NIXOS_OZONE_WL QT_QPA_PLATFORM ELECTRON_OZONE_PLATFORM_HINT

  ${pkgs.systemd}/bin/systemctl --user reset-failed \
    xdg-desktop-portal.service \
    xdg-desktop-portal-gnome.service \
    xdg-desktop-portal-gtk.service 2>/dev/null || true

  ${pkgs.systemd}/bin/systemctl --user restart xdg-desktop-portal.service 2>/dev/null || true
''
