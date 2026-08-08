{ lib, config, pkgs, ... }:
let
  cfg = config.module.nordic;
in
{
  options.module.nordic.enable = lib.mkEnableOption "nordic theme package";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.nordic ];
  };
}
