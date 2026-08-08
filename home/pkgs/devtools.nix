{ lib, config, pkgs, ... }:
let
  cfg = config.module.devtools;
in
{
  options.module.devtools.enable = lib.mkEnableOption "nodejs python gcc dotnet sdk";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nodejs
      python3
      gcc
      dotnet-sdk_8
    ];
  };
}
