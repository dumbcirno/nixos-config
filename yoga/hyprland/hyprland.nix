{ pkgs, ... }:
{
 home.packages = with pkgs; [
    hyprland
    xdg-desktop-portal-hyprland
    hyprpaper
    brightnessctl
    grimblast
    kdePackages.dolphin
 ];

 wayland.windowManager.hyprland.enable = true;
}
