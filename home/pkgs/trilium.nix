{ lib, config, pkgs, ... }:
let
  cfg = config.module.trilium;
in
{
  options.module.trilium.enable = lib.mkEnableOption "trilium notes";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.trilium-desktop ];
  };
}
