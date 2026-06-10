{ wallpaper, lockpaper, ... }:
{
  programs.noctalia.settings = {
    shell = {
      font_family = "JetBrains Mono";
      time_format = "{:%H:%M}";
      date_format = "%e %B, %A";
      polkit_agent = true;
      settings_show_advanced = true;
    };

    theme = {
      mode = "dark";
      source = "custom";
      custom_palette = "mami";
    };

    wallpaper = {
      enabled = true;
      fill_mode = "crop";
      default = {
        path = wallpaper;
      };
    };

    lockscreen = {
      wallpaper = lockpaper;
    };

    notification = {
      enable_daemon = true;
    };

    osd = {
      kinds = {
        volume = true;
        volume_output = true;
        volume_input = true;
        brightness = true;
        wifi = true;
        keyboard_layout = true;
      };
    };

    idle = {
      behavior = {
        lock = {
          timeout = 300;
          command = "noctalia:session lock";
          enabled = true;
        };
        "screen-off" = {
          timeout = 600;
          command = "noctalia:dpms-off";
          resume_command = "noctalia:dpms-on";
          enabled = true;
        };
      };
    };

    bar = {
      main = {
        position = "top";
        thickness = 32;
        background_opacity = 0.55;
        widget_spacing = 8;
        reserve_space = true;
        capsule = true;
        margin_h = 0;
        margin_v = 0;
        padding = 8;
        start = [ "workspaces" ];
        center = [ "weebquote" "clock" ];
        end = [
          "keyboard_layout"
          "network"
          "brightness"
          "volume_output"
          "volume_input"
          "battery"
        ];
      };
    };

    plugins = {
      enabled = [ "mami/weebquote" ];
      source = [
        {
          name = "mami-local";
          kind = "path";
          location = "~/.config/noctalia/plugins";
        }
      ];
    };

    widget = {
      workspaces = {
        display = "none";
        minimal = true;
        focused_color = "primary";
        occupied_color = "on_surface_variant";
        empty_color = "on_surface_variant";
      };

      weebquote = {
        type = "mami/weebquote:weebquote";
      };

      clock = {
        format = "{:%H:%M}";
        tooltip_format = "{:%e %B, %A}";
      };

      keyboard_layout = {
        display = "short";
        show_icon = true;
        show_label = true;
        custom_labels = {
          "English (US)" = "us";
          "Russian" = "ru";
        };
      };

      brightness = {
        mode = {
          type = "systemd";
          subsystem = "backlight";
          name = "intel_backlight";
        };
      };

      volume_output = {
        type = "volume";
        device = "output";
      };

      volume_input = {
        type = "volume";
        device = "input";
      };
    };
  };
}
