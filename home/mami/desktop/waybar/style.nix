{ ... }:
let
  custom = {
    font = "Jetbrains Mono";
    font_size = "16px";
    glass_bg = "rgba(255, 255, 255, 0.10)";
    glass_border = "rgba(255, 255, 255, 0.18)";
    glass_border_top = "rgba(255, 255, 255, 0.28)";
    glass_shadow = "rgba(0, 0, 0, 0)";
    fg = "rgba(233, 238, 245, 0.88)";
    fg_dim = "rgba(233, 238, 245, 0.62)";
    accent = "#000000";
    danger = "#FF3B30";
  };

  glassPill = ''
    background: ${custom.glass_bg};
    border: 1px solid ${custom.glass_border};
    border-top-color: ${custom.glass_border_top};
    border-radius: 14px;
    box-shadow: 0 2px 8px ${custom.glass_shadow};
  '';
in
{
  programs.waybar.style = ''
    window#waybar {
      background: transparent;
    }

    window#waybar.left-pill #waybar,
    window#waybar.center-pill #waybar,
    window#waybar.right-pill #waybar {
      min-height: 32px;
      color: ${custom.fg};
      font-family: ${custom.font};
      font-size: ${custom.font_size};
      padding: 0 10px;
      ${glassPill}
    }

    #workspaces,
    #custom-weebquote,
    #network,
    #backlight,
    #pulseaudio,
    #wireplumber-output,
    #wireplumber-input,
    #pulseaudio-input,
    #language,
    #clock,
    #battery {
      padding: 6px 4px;
      background: transparent;
      border: none;
      box-shadow: none;
    }

    #workspaces button {
      font-size: ${custom.font_size};
      padding: 0 1px;
      color: ${custom.fg};
      border: none;
    }

    #workspaces button.active {
      color: ${custom.accent};
    }

    #workspaces button.urgent {
      color: ${custom.danger};
    }

    #workspaces button:hover {
      background: none;
      color: ${custom.accent};
    }
  '';
}
