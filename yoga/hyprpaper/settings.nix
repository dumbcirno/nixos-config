{ lib, ... }:
{
  services.hyprpaper = {
  enable = true;
  settings = {
    preload = [
      "${./wallaper.jpg}"
    ];
    wallpaper = [
      "${./wallaper.jpg}"
    ];
  };
};
}