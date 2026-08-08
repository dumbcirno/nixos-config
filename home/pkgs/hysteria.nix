{ lib, config, pkgs, ... }:
let
  cfg = config.module.hysteria;
in
{
  options.module.hysteria.enable = lib.mkEnableOption "hysteria";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.hysteria ];
  };
}
