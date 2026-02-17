{ config, pkgs, ... }:
let
  # Get the flake root path
  flakePath = builtins.toString ./.;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${flakePath}/hyprpaper/wallpaper.jpg"
      ];
      wallpaper = [
        "${flakePath}/hyprpaper/wallpaper.jpg"
      ];
    };
  };
}