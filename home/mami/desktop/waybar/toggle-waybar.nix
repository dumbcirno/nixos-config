{ pkgs }:
pkgs.writeShellScript "toggle-waybar" ''
  ${pkgs.procps}/bin/pkill -USR1 -x waybar 2>/dev/null || true
''
