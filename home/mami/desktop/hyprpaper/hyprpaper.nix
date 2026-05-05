{ config, pkgs, ... }:
{
  # NOTE: this file lives in home/mami/desktop/hyprpaper/, so repo root is ../../../../
  # Use a Nix path so it gets copied into the store.
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${../../../../assets/wallpaper.jpg}"
      ];
      wallpaper = [
        ",${../../../../assets/wallpaper.jpg}"
      ];
    };
  };
}
