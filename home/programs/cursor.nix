{ lib, config, linuxUnstablePkgs, ... }:
let
  cfg = config.module.cursor;
in
{
  options.module.cursor.enable = lib.mkEnableOption "cursor editor";

  config = lib.mkIf cfg.enable {
    home.packages = [ linuxUnstablePkgs.code-cursor ];
  };
}
