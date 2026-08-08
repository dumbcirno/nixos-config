{ lib, config, ... }:
let
  cfg = config.module.nix-index;
in
{
  options.module.nix-index.enable = lib.mkEnableOption "nix-index";
  config = lib.mkIf cfg.enable {
    programs.nix-index.enable = true;
  };
}
