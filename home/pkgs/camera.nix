{ lib, config, pkgs, ... }:
let
  cfg = config.module.camera;
in
{
  options.module.camera.enable = lib.mkEnableOption "camera app and v4l tools";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      snapshot
      v4l-utils
    ];
  };
}
