{ ... }:
{
  programs.waybar.settings.mainBar = {
    layer = "top";
    position = "top";
    height = 32;
    spacing = 8;

    modules-left = [
      "niri/workspaces"
    ];

    modules-center = [
      "clock"
    ];

    modules-right = [
      "niri/language"
      "network"
      "backlight"
      "wireplumber#output"
      "pulseaudio#input"
      "battery"
    ];

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
}
