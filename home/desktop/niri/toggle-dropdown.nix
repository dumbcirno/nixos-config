{ lib, pkgs, niriPackage }:
let
  niri = lib.getExe niriPackage;
  foot = lib.getExe pkgs.foot;
  zellij = lib.getExe pkgs.zellij;
in
pkgs.writeShellApplication {
  name = "toggle-dropdown";
  runtimeInputs = [ pkgs.jq pkgs.coreutils ];
  text = ''
    set -eu

    app_id="dropdown"
    session="dropdown"

    windows="$(${niri} msg --json windows)"
    window_id="$(jq -r --arg app "$app_id" 'first(.[] | select(.app_id == $app) | .id) // empty' <<<"$windows")"

    if [ -z "$window_id" ]; then
      exec ${foot} -a "$app_id" ${zellij} attach --create --force-run-commands "$session"
    fi

    ${niri} msg action close-window --id "$window_id"
  '';
}
