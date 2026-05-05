{ config, pkgs, ... }:
{
  # NOTE: this file lives in home/mami/hyprpaper/, so repo root is ../../../
  # Use a Nix path so it gets copied into the store.
  #
  # repoRoot = ../../../.
  # wallpaperFile = repoRoot + "/assets/wallpaper.jpg";
  #
  # (We inline it below to keep it simple.)
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${../../../assets/wallpaper.jpg}"
      ];
      wallpaper = [
        ",${../../../assets/wallpaper.jpg}"
      ];
    };
  };
}