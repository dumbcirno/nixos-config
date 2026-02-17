{ lib, ... }:
{
  services.hyprpaper = {
  enable = true;
  settings = {
    preload = [
      "./wallaper.jpg"
    ];
    wallpaper = [
      ",./wallpaper.jpg"
    ];
  };
};
}