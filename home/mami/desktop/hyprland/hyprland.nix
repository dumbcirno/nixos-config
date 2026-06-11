{ pkgs, ... }:
{
 home.packages = with pkgs; [
    hyprland
    xdg-desktop-portal-hyprland
    brightnessctl
    grimblast
    kdePackages.dolphin
 ];

 wayland.windowManager.hyprland.enable = true;
}
