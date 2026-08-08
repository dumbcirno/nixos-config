{ lib, config, pkgs, ... }:
let
  cfg = config.module.zellij;
in
{
  options.module.zellij.enable = lib.mkEnableOption "zellij";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ zellij ];

    programs.zellij.enable = true;
    programs.zellij.enableFishIntegration = false;
    programs.zellij.settings = {
      theme = "nord";
      default_layout = "compact";
    };
  };
}
