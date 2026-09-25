{ lib, config, pkgs, ... }:
let
  cfg = config.module.chrome;
in
{
  options.module.chrome.enable = lib.mkEnableOption "google chrome";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.google-chrome ];
  };
}
