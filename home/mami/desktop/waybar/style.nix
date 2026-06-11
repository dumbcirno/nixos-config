{ ... }:
let
  custom = {
    font = "Jetbrains Mono";
    font_size = "16px";
    background = "rgba(0, 0, 0, 0.55)";
    fg = "rgba(233, 238, 245, 0.88)";
    fg_dim = "rgba(233, 238, 245, 0.62)";
    accent = "#000000";
    danger = "#FF3B30";
    margins = {
      primary = "4px";
      partial-primary = "2px";
    };
  };
in
{
  programs.waybar.style = ''
    window#waybar {
      background: transparent;
    }

    #waybar {
      min-height: 32px;
      background: ${custom.background};
      color: ${custom.fg};
      font-family: ${custom.font};
      font-size: ${custom.font_size};
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
    #language,
    #battery {
      padding: 6px 10px;
    }

    #workspaces,
    #language,
    #network,
    #backlight,
    #wireplumber,
    #pulseaudio,
    #battery,
    #clock {
      margin: ${custom.margins.primary} ${custom.margins.primary} ${custom.margins.partial-primary} ${custom.margins.primary};
      background: ${custom.background};
      padding-left: 10px;
      padding-right: 10px;
      border-radius: 14px;
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
