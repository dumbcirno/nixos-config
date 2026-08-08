{ lib, config, pkgs, ... }:
let
  cfg = config.module.libqalculate;
in
{
  options.module.libqalculate.enable = lib.mkEnableOption "libqalculate";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.libqalculate ];
  };
}
