{ lib, pkgs, noctalia }:
let
  noctaliaPackage = noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
  name = "launch-noctalia";
  drv = pkgs.writeShellScript name ''
    if ${pkgs.procps}/bin/pgrep -x noctalia >/dev/null 2>&1; then
      exit 0
    fi

    export XDG_CURRENT_DESKTOP=niri
    export XDG_SESSION_TYPE=wayland
    export GDK_BACKEND=wayland
    export GTK_USE_PORTAL=0

    for _ in $(${pkgs.coreutils}/bin/seq 1 100); do
      if [ -n "''${WAYLAND_DISPLAY:-}" ]; then
        break
      fi
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
      ${pkgs.coreutils}/bin/sleep 0.1
    done

    if [ -z "''${WAYLAND_DISPLAY:-}" ]; then
      echo "launch-noctalia: WAYLAND_DISPLAY not available" >&2
      exit 1
    fi

    ${lib.getExe noctaliaPackage} &
  '';
in
"${drv}/${name}"
