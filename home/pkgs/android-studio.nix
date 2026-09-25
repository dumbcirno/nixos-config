{ lib, config, pkgs, ... }:
let
  cfg = config.module.android-studio;
in
{
  options.module.android-studio.enable = lib.mkEnableOption "android studio";
  config = lib.mkIf cfg.enable {
    nixpkgs.config.android_sdk.accept_license = true;
    home.packages = [ pkgs.android-studio ];
  };
}
