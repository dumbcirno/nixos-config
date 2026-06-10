{ lib, linuxUnstablePkgs, pkgs, ... }:
let
  wallpaper = "${../../../../assets/wallpaper.png}";
  exportPortalEnv = import ./portal-env-script.nix pkgs;
  launchWaybar = lib.getExe (import ../waybar/launch-waybar.nix {
    inherit lib pkgs;
    waybarPackage = linuxUnstablePkgs.waybar;
  });
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

    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

    spawn-at-startup = [
      { argv = [ exportPortalEnv ]; }
      { argv = [ "swaybg" "-m" "fill" "-i" wallpaper ]; }
      {
        argv = [
          "swayidle"
          "-w"
          "timeout"
          "300"
          "swaylock"
          "-f"
          "timeout"
          "600"
          "niri"
          "msg"
          "action"
          "power-off-monitors"
          "resume"
          "niri"
          "msg"
          "action"
          "power-on-monitors"
          "before-sleep"
          "swaylock"
          "-f"
        ];
      }
      { argv = [ "mako" ]; }
      { sh = "sleep 2; exec ${launchWaybar}"; }
      { sh = "sleep 5; exec ${waybar}"; }
      { argv = [ "elephant" ]; }
      { argv = [ "walker" "--gapplication-service" ]; }
      { argv = [ "foot" ]; }
      { sh = "sleep 2; exec ${lib.getExe pkgs.foot}"; }
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
        "Mod+D".action.spawn = [ "walker" ];
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
        "Print".action.screenshot = [ ];
        "Mod+Print".action.screenshot-screen = [ ];
        "Alt+Print".action.screenshot-window = [ ];
      }
      // workspaceFocusBinds
      // workspaceMoveBinds;
  };
}
