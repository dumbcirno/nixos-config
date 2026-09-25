{ lib, config, pkgs, ... }:
let
  cfg = config.module.media-tools;
in
{
  options.module.media-tools.enable = lib.mkEnableOption "imagemagick ffmpeg p7zip";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      imagemagick
      ffmpeg
      p7zip
    ];
  };
}
