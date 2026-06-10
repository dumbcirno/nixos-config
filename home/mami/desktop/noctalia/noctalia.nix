{ noctalia, pkgs, ... }:
let
  wallpaper = "${../../../../assets/wallpaper.png}";
  lockpaper = "${../../../../assets/lockpaper.jpg}";
  pluginRoot = ./plugins;
in
{
  imports = [ (import ./settings.nix { inherit wallpaper lockpaper; }) ];

  programs.noctalia = {
    enable = true;
    systemd.enable = false;
    package = noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;

    customPalettes.mami = {
      dark = {
        mPrimary = "#2AABEE";
        mOnPrimary = "#000000";
        mSecondary = "#2AABEE";
        mOnSecondary = "#000000";
        mTertiary = "#2AABEE";
        mOnTertiary = "#000000";
        mError = "#FF3B30";
        mOnError = "#000000";
        mSurface = "#000000";
        mOnSurface = "#E9EEF5";
        mSurfaceVariant = "#1A1A1A";
        mOnSurfaceVariant = "#E9EEF59E";
        mOutline = "#FFFFFF1F";
        mShadow = "#000000";
        mHover = "#0000004D";
        mOnHover = "#E9EEF5";
      };
    };
  };

  xdg.configFile = {
    "noctalia/scripts/weebquote" = {
      source = ./scripts/weebquote;
      executable = true;
    };

    "noctalia/plugins/mami/weebquote" = {
      source = "${pluginRoot}/weebquote";
      recursive = true;
    };
  };
}
