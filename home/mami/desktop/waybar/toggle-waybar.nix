{ pkgs, launchWaybar }:
pkgs.writeShellScript "toggle-waybar" ''
  set -eu

  if ${pkgs.procps}/bin/pgrep -x waybar >/dev/null 2>&1; then
    ${pkgs.procps}/bin/pkill -x waybar || true
    exit 0
  fi

  ${launchWaybar} &
''
