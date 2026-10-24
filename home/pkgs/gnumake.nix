{ lib, config, pkgs, ... }:
let
  cfg = config.module.gnumake;
in
{
  options.module.gnumake.enable = lib.mkEnableOption "gnumake";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.gnumake ];
  };
}
