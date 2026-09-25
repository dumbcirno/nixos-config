{ lib, config, pkgs, ... }:
let
  cfg = config.module.obs;
in
{
  options.module.obs.enable = lib.mkEnableOption "obs studio";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.obs-studio ];
  };
}
