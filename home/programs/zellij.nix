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
      theme = "nord-red";
      default_layout = "compact";
      on_force_close = "detach";
    };

    xdg.configFile."zellij/themes/nord-red.kdl".source = ./zellij/nord-red.kdl;
  };
}
