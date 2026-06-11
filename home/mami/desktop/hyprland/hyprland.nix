{ pkgs, ... }:
{
 home.packages = with pkgs; [
    hyprland
    xdg-desktop-portal-hyprland
    brightnessctl
    grimblast
    nautilus
 ];

 wayland.windowManager.hyprland.enable = true;
}
