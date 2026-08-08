{ lib, config, pkgs, ... }:
let
  cfg = config.module.firefox;
in
{
  options.module.firefox.enable = lib.mkEnableOption "firefox";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.firefox ];
  };
}
