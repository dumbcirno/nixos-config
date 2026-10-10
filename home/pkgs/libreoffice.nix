{ lib, config, pkgs, ... }:
let
  cfg = config.module.libreoffice;
in
{
  options.module.libreoffice.enable = lib.mkEnableOption "libreoffice";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      libreoffice-fresh
      hunspell
      hunspellDicts.ru_RU
      hunspellDicts.en_US
    ];
  };
}
