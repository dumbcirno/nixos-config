{ lib, config, ... }:
let
  cfg = config.module.rider;
in
{
  options.module.rider.enable = lib.mkEnableOption "rider";

  config = lib.mkIf cfg.enable {
    # Placeholder: add JetBrains Rider package when needed.
    home.packages = [ ];
  };
}
