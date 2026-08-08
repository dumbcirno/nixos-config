{ lib, config, pkgs, ... }:
let
  cfg = config.module.nil;
in
{
  options.module.nil.enable = lib.mkEnableOption "nil (nix lsp)";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.nil ];
  };
}
