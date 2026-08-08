{ lib, config, pkgs, ... }:
let
  cfg = config.module.wl-clipboard;
in
{
  options.module.wl-clipboard.enable = lib.mkEnableOption "wl-clipboard";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.wl-clipboard ];
  };
}
