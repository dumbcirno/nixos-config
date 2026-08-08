{ lib, config, pkgs, ... }:
let
  cfg = config.module.git;
in
{
  options.module.git.enable = lib.mkEnableOption "git";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.git ];
  };
}
