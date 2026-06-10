{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brightnessctl
    grimblast
    kdePackages.dolphin
    swaybg
  ];
}
