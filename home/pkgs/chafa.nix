{ lib, config, pkgs, ... }:
let
  cfg = config.module.chafa;
in
{
  options.module.chafa.enable = lib.mkEnableOption "chafa";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.chafa ];
  };
}
