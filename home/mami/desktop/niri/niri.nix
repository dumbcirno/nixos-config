{ pkgs, ... }:
{
  home.packages = with pkgs; [
    xwayland-satellite
    brightnessctl
    grimblast
    kdePackages.dolphin
    swaybg
  ];
}
