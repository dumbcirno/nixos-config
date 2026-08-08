{ lib, config, pkgs, ... }:
let
  cfg = config.module.telegram;
in
{
  options.module.telegram.enable = lib.mkEnableOption "telegram-desktop";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.telegram-desktop ];
  };
}
