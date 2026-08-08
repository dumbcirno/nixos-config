{ lib, config, pkgs, ... }:
let
  cfg = config.module.audio-tools;
in
{
  options.module.audio-tools.enable = lib.mkEnableOption "pavucontrol and pamixer";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      pavucontrol
      pamixer
    ];
  };
}
