{ lib, config, pkgs, ... }:
let
  cfg = config.module.cloud-tools;
in
{
  options.module.cloud-tools.enable = lib.mkEnableOption "kubectl helm lens awscli dive";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      kubectl
      kubernetes-helm
      lens
      awscli2
      dive
    ];
  };
}
