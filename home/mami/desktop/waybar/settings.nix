{ ... }:
{
  programs.waybar.settings.mainBar = {
    layer = "top";
    spacing = 8;

    modules-left = [
      "hyprland/workspaces"
    ];
    
    modules-center = [
      "custom/weebquote"
      "clock"
    ];

    modules-right = [
      "hyprland/language"
      "network"
      "backlight"
      "wireplumber#output"
      "pulseaudio#input"
      "battery"
  ];

  "custom/weebquote" = {
    exec = "~/.config/waybar/scripts/weebquote";
    interval = 1;
    return-type = "json";
    max-length = 42;
    on-click = "~/.config/waybar/scripts/weebquote --force";
  };

  "hyprland/workspaces" = {
    "format" = "●";
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
    format-source = "<span color='#2AABEE'>󰍬 on</span>";
    format-source-muted = "󰍭 off";

    on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
  };

  "wireplumber#output" = {
    format = "{icon} {volume}%";
    format-muted = "󰝟 off";
    
    format-icons = [ "󰕿" "󰖀" "󰕾" "󱄠" ];
    on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
    };

  "hyprland/language" = {
    format = "󰌌 {}";
    format-en = "us";
    format-ru = "ru";
  };

  clock = {
    format = "{:%H:%M}";

    tooltip = true;
    tooltip-format = "{:%e %B, %A}";  # 2 April, Saturday
  };

  backlight = {
    device = "intel_backlight";
    format = "{icon} {percent}%";
    format-icons = ["󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩔" "󱩕" "󱩖" "󰛨"];
};

network = {
  format = "{ifname}";
  format-wifi = "{icon} {essid}";
  tooltip-format-wifi = "{essid} {signalStrength}%";
  format-disconnected = "";
  format-icons = {
    wifi = ["󰤯" "󰤟" "󰤢" "󰤨"];
  };
  max-length = 20;
  };
};
}
