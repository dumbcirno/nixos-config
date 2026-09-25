{ lib, config, pkgs, ... }:
let
  cfg = config.module.zoom;
in
{
  options.module.zoom.enable = lib.mkEnableOption "zoom";
  config = lib.mkIf cfg.enable {
    home.packages = [
      (pkgs.zoom-us.override {
        gnomeXdgDesktopPortalSupport = true;
      })
    ];
  };
}
