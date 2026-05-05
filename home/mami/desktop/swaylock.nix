{ pkgs, ... }:
let
  glass = {
    fg = "rgb(233, 238, 245)";
    fgDim = "rgba(233, 238, 245, 0.70)";
    panel = "rgba(10, 14, 18, 0.72)";
    panelBorder = "rgba(255, 255, 255, 0.10)";
    accent = "rgb(42, 171, 238)";
  };
in {
  home.packages = with pkgs; [
    hyprlock
  ];

  programs.hyprlock.enable = true;

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
      dots_size = 0.2; # scale of input-field height, 0.2 - 0.8
      dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
      dots_center = true;
      outer_color = "rgba(0, 0, 0, 0)";
      inner_color = glass.panel;
      font_color = glass.fg;
      fade_on_empty = false;
      font_family = "JetBrains Mono Nerd Font Mono";
      #placeholder_text = "<span foreground=\"##cdd6f4\">Input Password...</span>";
      placeholder_text = "<span foreground=\"${glass.fgDim}\">Input Password...</span>";
      hide_input = false;
      position = "0, -120";
      halign = "center";
      valign = "center";
    };

      label = [
      {
         monitor = "";
         text = "cmd[update:1000] echo \"$(date +\"%-I:%M%p\")\"";
         color = glass.fgDim;
         font_size = 120;
         font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
         position = "0, -300";
         halign = "center";
         valign = "top";
       }

# USER
       {
         monitor = "";
         text = "Hi there, $USER";
         color = glass.fgDim;
         font_size = 25;
         font_family = "JetBrains Mono Nerd Font Mono";
         position = "0, -40";
         halign = "center";
         valign = "center";
       }
    ];
  };
}

