{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprlock
  ];

  programs.hyprlock.settings = {
    background = {
      monitor = "";
      path = "~/.bg/bed_2x.png";
      blur_passes = 2;
    };

    general = {
      no_fade_in = false;
      grace = 0;
      disable_loading_bar = true;
    };

    input-field = {
      monitor = "";
      size = "250, 60";
      outline_thickness = 2;
      dots_size = 0.2;
      dots_spacing = 0.2;
      dots_center = true;
      outer_color = "rgba(0, 0, 0, 0)";
      inner_color = "rgba(10, 14, 18, 0.72)";
      font_color = "rgb(233, 238, 245)";
      fade_on_empty = false;
      font_family = "JetBrains Mono Nerd Font Mono";
      placeholder_text = "<span foreground=\"rgba(233, 238, 245, 0.70)\">Input Password...</span>";
      hide_input = false;
      position = "0, -120";
      halign = "center";
      valign = "center";
    };

    label = [
      {
        monitor = "";
        text = "cmd[update:1000] echo \"$(date +\"%-I:%M%p\")\"";
        color = "rgba(233, 238, 245, 0.70)";
        font_size = 120;
        font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
        position = "0, -300";
        halign = "center";
        valign = "top";
      }
      {
        monitor = "";
        text = "Hi there, $USER";
        color = "rgba(233, 238, 245, 0.70)";
        font_size = 25;
        font_family = "JetBrains Mono Nerd Font Mono";
        position = "0, -40";
        halign = "center";
        valign = "center";
      }
    ];
  };
}
