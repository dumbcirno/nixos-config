{ pkgs, ... }:
{
 home.packages = with pkgs; [
    hyprland
    xdg-desktop-portal-hyprland
    brightnessctl
    grimblast
 ];

 wayland.windowManager.hyprland.enable = true;
}
