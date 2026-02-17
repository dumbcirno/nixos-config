{ pkgs, ... }:
{
 home.packages = with pkgs; [
    hypraper
 ];

 wayland.windowManager.hyprland.enable = true;
}
