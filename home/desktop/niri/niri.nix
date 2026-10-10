{ lib, linuxUnstablePkgs, pkgs, ... }:
{
  home.packages = [
    linuxUnstablePkgs.xwayland-satellite
    (import ./toggle-dropdown.nix {
      inherit lib pkgs;
      niriPackage = linuxUnstablePkgs.niri;
    })
  ] ++ (with pkgs; [
    brightnessctl
    swaybg
    swayidle
    mako
    polkit_gnome
  ]);
}
