{ ... }:
let
  # Used to left/right-align narrow pill bars via margin trick (see waybar bar.cpp).
  # Tune if pills are misaligned on your monitor.
  monitorWidth = 1920;

  pillBar = {
    layer = "top";
    position = "top";
    height = 32;
    spacing = 8;
    exclusive = false;
    "margin-top" = 4;
  };

  modules = {
    "niri/workspaces" = {
      format = "●";
      all-outputs = true;
    };

    battery = {
      format = "{icon} {capacity}%";
      tooltip-format = "{timeTo} | {power}w";
      format-icons = [ "󰂃" "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];

      states = {
        critical = 10;
        warning = 25;
        low = 50;
        full = 100;
      };
    };

    "pulseaudio#input" = {
      format = "{format_source}";
      format-source = "󰍬 on";
      format-source-muted = "󰍭 off";
      on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
    };

    "wireplumber#output" = {
      format = "{icon} {volume}%";
      format-muted = "󰝟 off";
      format-icons = [ "󰕿" "󰖀" "󰕾" "󱄠" ];
      on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
    };

    "niri/language" = {
      format-en = "󰌌 us";
      format-ru = "󰌌 ru";
    };

    clock = {
      format = "{:%H:%M}";
      tooltip = true;
      tooltip-format = "{:%e %B, %A}";
    };

    backlight = {
      device = "intel_backlight";
      format = "{icon} {percent}%";
      format-icons = [ "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩔" "󱩕" "󱩖" "󰛨" ];
    };

    network = {
      format = "{ifname}";
      format-wifi = "{icon} {essid}";
      tooltip-format-wifi = "{essid} {signalStrength}%";
      format-disconnected = "";
      format-icons = {
        wifi = [ "󰤯" "󰤟" "󰤢" "󰤨" ];
      };
      max-length = 20;
    };
  };

  leftPillWidth = 120;
  centerPillWidth = 90;
  rightPillWidth = 520;
  pillMargin = 4;
in
{
  programs.waybar.settings = {
    leftPill = pillBar // modules // {
      name = "left-pill";
      width = leftPillWidth;
      "margin-left" = pillMargin;
      "margin-right" = monitorWidth - leftPillWidth - pillMargin;
      modules-left = [ "niri/workspaces" ];
    };

    centerPill = pillBar // modules // {
      name = "center-pill";
      width = centerPillWidth;
      modules-center = [ "clock" ];
    };

    rightPill = pillBar // modules // {
      name = "right-pill";
      width = rightPillWidth;
      "margin-left" = monitorWidth - rightPillWidth - pillMargin;
      "margin-right" = pillMargin;
      modules-right = [
        "niri/language"
        "network"
        "backlight"
        "wireplumber#output"
        "pulseaudio#input"
        "battery"
      ];
    };
  };
}
