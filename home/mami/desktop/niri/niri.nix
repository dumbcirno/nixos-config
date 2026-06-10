{ linuxUnstablePkgs, pkgs, ... }:
{
  home.packages = [
    linuxUnstablePkgs.xwayland-satellite
  ] ++ (with pkgs; [
    brightnessctl
    grimblast
    kdePackages.dolphin
  ]);
}
