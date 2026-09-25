{ lib, config, pkgs, ... }:
let
  cfg = config.module.thunderbird;
in
{
  options.module.thunderbird.enable = lib.mkEnableOption "thunderbird";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.thunderbird ];
  };
}
