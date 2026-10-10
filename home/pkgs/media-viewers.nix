{ lib, config, pkgs, ... }:
let
  cfg = config.module.media-viewers;
  imageTypes = [
    "image/avif"
    "image/bmp"
    "image/gif"
    "image/heic"
    "image/heif"
    "image/jpeg"
    "image/png"
    "image/svg+xml"
    "image/tiff"
    "image/webp"
    "image/x-icon"
    "image/x-portable-anymap"
    "image/x-xpixmap"
  ];
  mediaTypes = [
    "application/mxf"
    "application/ogg"
    "application/x-matroska"
    "audio/aac"
    "audio/flac"
    "audio/mpeg"
    "audio/ogg"
    "audio/opus"
    "audio/x-m4a"
    "audio/x-wav"
    "video/mp4"
    "video/mpeg"
    "video/ogg"
    "video/quicktime"
    "video/webm"
    "video/x-matroska"
    "video/x-ms-wmv"
    "video/x-msvideo"
  ];
in
{
  options.module.media-viewers.enable = lib.mkEnableOption "mpv and imv";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      mpv
      imv
    ];

    # Packaged imv.desktop has NoDisplay=true, so Nautilus hides it.
    xdg.desktopEntries.imv = {
      name = "imv";
      genericName = "Image viewer";
      comment = "Fast Image Viewer";
      exec = "imv %F";
      icon = "multimedia-photo-viewer";
      terminal = false;
      categories = [
        "Graphics"
        "2DGraphics"
        "Viewer"
      ];
      mimeType = imageTypes;
    };

    xdg.mimeApps.enable = true;
    xdg.mimeApps.defaultApplications =
      (lib.genAttrs imageTypes (_: [ "imv.desktop" ]))
      // (lib.genAttrs mediaTypes (_: [ "mpv.desktop" ]));
    xdg.mimeApps.associations.added =
      (lib.genAttrs imageTypes (_: [ "imv.desktop" ]))
      // (lib.genAttrs mediaTypes (_: [ "mpv.desktop" ]));
  };
}
