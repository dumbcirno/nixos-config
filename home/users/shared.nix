# Shared imports for every home-manager user on mami.
# Toggle apps in home/users/<name>/default.nix via module.*.enable.
{ ... }:
{
  imports = [
    ../../core
    ../../theme
    ../../desktop
    ../../programs
    ../../pkgs
  ];
}
