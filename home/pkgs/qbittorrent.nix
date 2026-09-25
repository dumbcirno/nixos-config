{ lib, config, pkgs, ... }:
let
  cfg = config.module.qbittorrent;
in
{
  options.module.qbittorrent.enable = lib.mkEnableOption "qbittorrent";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.qbittorrent ];
  };
}
