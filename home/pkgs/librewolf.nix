{ lib, config, linuxUnstablePkgs, ... }:
let
  cfg = config.module.librewolf;
in
{
  options.module.librewolf.enable = lib.mkEnableOption "librewolf";
  config = lib.mkIf cfg.enable {
    home.packages = [ linuxUnstablePkgs.librewolf ];
  };
}
