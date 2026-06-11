{ linuxUnstablePkgs, pkgs, ... }:
{
  home.packages = [
    linuxUnstablePkgs.xwayland-satellite
  ] ++ (with pkgs; [
    brightnessctl
    nautilus
    swaybg
    swayidle
    mako
  ]);
}
