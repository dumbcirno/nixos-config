{ config, ... }:
let custom = {
  font = "Jetbrains Mono";
  font_size = "16px";
  background = "rgba(0, 0, 0, 0.55)";
  fg = "rgba(233, 238, 245, 0.88)";
  fg_dim = "rgba(233, 238, 245, 0.62)";
  accent = "#2AABEE";
  danger = "#FF3B30";
};
in 
{
  programs.waybar.style = ''
#waybar {
  background: ${custom.background};
  color: ${custom.fg};
  font-family: ${custom.font};
  font-size: ${custom.font_size};
}

/* padding */

#workspaces,
#custom-weebquote,
#network,
#backlight,
#pulseaudio,
#wireplumber.output,
#wireplumber.input,
#language,
#clock,
#language,
#battery {
  padding: 6px 10px;
}
#workspaces {
  padding-left: 20px;
}

#battery {
  margin-right: 20px;
}

/* quote */

#custom-weebquote {
  padding: 6px 12px;
  border-radius: 999px;
  background: rgba(0, 0, 0, 0.20);
  color: ${custom.fg};
}

#custom-weebquote:hover {
  background: rgba(0, 0, 0, 0.30);
}

/* workspaces */

#workspaces button {
  font-size: ${custom.font_size};
  padding: 0 1px;
  color: ${custom.fg_dim};
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
