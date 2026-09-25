{ lib, config, pkgs, ... }:
let
  cfg = config.module.db-clients;
in
{
  options.module.db-clients.enable = lib.mkEnableOption "mongosh mongodb compass postgresql client";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      mongosh
      mongodb-compass
      postgresql
    ];
  };
}
