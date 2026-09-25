{ lib, config, pkgs, ... }:
let
  cfg = config.module.postman;
in
{
  options.module.postman.enable = lib.mkEnableOption "postman";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.postman ];
  };
}
