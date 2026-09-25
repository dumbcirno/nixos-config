{ lib, config, pkgs, ... }:
let
  cfg = config.module.wireshark;
in
{
  options.module.wireshark.enable = lib.mkEnableOption "wireshark";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.wireshark ];
  };
}
