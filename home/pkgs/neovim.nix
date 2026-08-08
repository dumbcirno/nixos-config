{ lib, config, pkgs, ... }:
let
  cfg = config.module.neovim;
in
{
  options.module.neovim.enable = lib.mkEnableOption "neovim";
  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.neovim ];
  };
}
