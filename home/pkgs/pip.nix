{ lib, config, pkgs, ... }:
let
  cfg = config.module.pip;
in
{
  options.module.pip.enable = lib.mkEnableOption "pip";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.python3Packages.pip ];
  };
}
