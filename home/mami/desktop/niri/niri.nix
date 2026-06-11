{ linuxUnstablePkgs, pkgs, ... }:
{
  home.packages = [
    linuxUnstablePkgs.xwayland-satellite
  ] ++ (with pkgs; [
    brightnessctl
    swaybg
    swayidle
    mako
  ]);
}
