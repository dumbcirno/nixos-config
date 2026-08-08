{ lib, config, pkgs, ... }:
let
  cfg = config.module.gajim;
in
{
  options.module.gajim.enable = lib.mkEnableOption "gajim";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.gajim ];
  };
}
