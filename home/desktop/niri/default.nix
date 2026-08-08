{ lib, ... }:
{
  imports = [
    ./niri.nix
    ./portal-env.nix
    ./settings.nix
  ];

  xdg.configFile."niri-config".target = lib.mkForce "niri/generated.kdl";

  xdg.configFile."niri/config.kdl".text = ''
    include "generated.kdl"
    include "appearance.kdl"
  '';

  xdg.configFile."niri/appearance.kdl".source = ./appearance.kdl;
}
