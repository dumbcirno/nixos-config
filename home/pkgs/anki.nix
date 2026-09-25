{ lib, config, pkgs, ... }:
let
  cfg = config.module.anki;
in
{
  options.module.anki.enable = lib.mkEnableOption "anki";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.anki ];
  };
}
