{ lib, linuxUnstablePkgs, pkgs, ... }:
let
  exportPortalEnv = import ./portal-env-script.nix pkgs;
  workspaceFocusBinds = lib.listToAttrs (
    map (x: {
      name = "Mod+${toString (lib.mod x 10)}";
      value = {
        action.focus-workspace = x;
      };
    }) (lib.lists.range 1 10)
  );
  workspaceMoveBinds = lib.listToAttrs (
    map (x: {
      name = "Mod+Shift+${toString (lib.mod x 10)}";
      value = {
        action.move-window-to-workspace = x;
      };
    }) (lib.lists.range 1 10)
  );
in
{
  programs.niri.settings = {
      xwayland-satellite.path = lib.getExe linuxUnstablePkgs.xwayland-satellite;

      spawn-at-startup = [
        { argv = [ exportPortalEnv ]; }
      ];

      input = {
        mod-key = "Super";
        keyboard.xkb = {
          layout = "us,ru";
          options = "grp:alt_shift_toggle";
        };
        touchpad = {
          natural-scroll = true;
          tap = true;
        };
      };

      layout = {
        gaps = 8;
        border = {
          enable = false;
        };
        focus-ring = {
          enable = false;
        };
        shadow = {
          enable = false;
        };
      };

      binds =
        {
          "Mod+Return".action.spawn = "foot";
          "Mod+Q".action.close-window = [ ];
          "Mod+M".action.quit = {
            skip-confirmation = true;
          };
          "Mod+E".action.spawn = "dolphin";
          "Mod+V".action.toggle-window-floating = [ ];
          "Mod+F".action.fullscreen-window = [ ];
          "Mod+D".action.spawn = [ "noctalia" "msg" "launcher" "toggle" ];
          "Mod+J".action.toggle-column-tabbed-display = [ ];
          "Mod+Left".action.focus-column-left = [ ];
          "Mod+Right".action.focus-column-right = [ ];
          "Mod+Up".action.focus-window-up = [ ];
          "Mod+Down".action.focus-window-down = [ ];
          "Mod+S".action.toggle-overview = [ ];
          "Mod+WheelScrollDown" = {
            cooldown-ms = 150;
            action.focus-workspace-down = [ ];
          };
          "Mod+WheelScrollUp" = {
            cooldown-ms = 150;
            action.focus-workspace-up = [ ];
          };
          "XF86AudioRaiseVolume".action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_SINK@"
            "10%+"
          ];
          "XF86AudioLowerVolume".action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_SINK@"
            "10%-"
          ];
          "XF86AudioMute".action.spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_SINK@"
            "toggle"
          ];
          "XF86AudioMicMute".action.spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SOURCE@"
            "toggle"
          ];
          "XF86MonBrightnessUp".action.spawn = [
            "brightnessctl"
            "set"
            "+10%"
          ];
          "XF86MonBrightnessDown".action.spawn = [
            "brightnessctl"
            "set"
            "10%-"
          ];
          "Print".action.spawn = [ "grimblast" "copy" ];
          "Mod+Print".action.spawn = [ "grimblast" "copy" "area" ];
        }
        // workspaceFocusBinds
        // workspaceMoveBinds;
  };
}
