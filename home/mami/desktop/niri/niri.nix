{ linuxUnstablePkgs, pkgs, ... }:
{
  home.packages = [
    linuxUnstablePkgs.xwayland-satellite
  ] ++ (with pkgs; [
    brightnessctl
    kdePackages.dolphin
  ]);
}
