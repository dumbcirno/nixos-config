{ lib, config, pkgs, ... }:
let
  cfg = config.module.devtools;
in
{
  options.module.devtools.enable = lib.mkEnableOption "nodejs python gcc dotnet sdk go rust jdk pnpm cmake playwright nswag";
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nodejs
      python3
      gcc
      dotnet-sdk_8
      go
      rustup
      jdk21
      pnpm
      cmake
      playwright-test
      playwright-driver.browsers
      (writeShellApplication {
        name = "nswag";
        runtimeInputs = [ nodejs ];
        text = ''
          exec npx --yes nswag@14.4.0 "$@"
        '';
      })
    ];

    home.sessionVariables = {
      PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
      PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = "1";
    };
  };
}
