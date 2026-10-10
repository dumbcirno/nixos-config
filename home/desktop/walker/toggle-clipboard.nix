{ lib, pkgs, walkerPackage, niriPackage }:
let
  niri = lib.getExe niriPackage;
  walker = lib.getExe walkerPackage;
in
pkgs.writeShellApplication {
  name = "toggle-clipboard";
  runtimeInputs = [ pkgs.jq pkgs.coreutils ];
  text = ''
    set -eu

    if ${niri} msg --json layers | jq -e '.[] | select(.namespace | test("^walker"))' >/dev/null; then
      exec ${walker} --close
    fi

    exec ${walker} --provider clipboard
  '';
}
