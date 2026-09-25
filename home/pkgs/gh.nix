{ lib, config, pkgs, ... }:
let
  cfg = config.module.gh;
in
{
  options.module.gh.enable = lib.mkEnableOption "github cli";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.gh ];
  };
}
