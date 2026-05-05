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
        "${flakePath}/assets/wallpaper.jpg"
      ];
      wallpaper = [
        ",${flakePath}/assets/wallpaper.jpg"
      ];
    };
  };
}