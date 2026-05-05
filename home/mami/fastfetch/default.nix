{ config, pkgs, ... }:
{
  xdg.configFile."fastfetch/logo.sixel".source =
    pkgs.runCommand "fastfetch-logo.sixel" { } ''
      # SIXEL output moves the cursor in some terminals.
      # Save/restore cursor position and then move right by logo width (28) + spacing (2)
      printf '\0337' > "$out"
      ${pkgs.chafa}/bin/chafa \
        --format sixel \
        -s 28x14 \
        ${./fetch.png} >> "$out"
      printf '\0338\033[30C' >> "$out"
    '';

  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        source = "${config.xdg.configHome}/fastfetch/logo.sixel";
        type = "file-raw";
        padding = {
          top = 0;
          left = 0;
        };
      };
      modules = [
        "break"
        {
          type = "custom";
          format = "┌────────────────────── Hardware ──────────────────────┐";
          outputColor = "red";
        }
        {
          type = "title";
          key = " PC";
          keyColor = "green";
        }
        {
          type = "cpu";
          key = "│ ├󰍛CPU";
          showPeCoreCount = true;
          format = "{1}";
          keyColor = "green";
        }
        {
          type = "gpu";
          key = "│ ├󰍛 GPU";
          keyColor = "green";
        }
        {
          type = "memory";
          key = "└ └󰍛 Memory";
          keyColor = "green";
        }
        {
          type = "custom";
          format = "└──────────────────────────────────────────────────────┘";
          outputColor = "red";
        }
        "break"
        {
          type = "custom";
          format = "┌────────────────────── Software ──────────────────────┐";
          outputColor = "red";
        }
        {
          type = "os";
          key = " OS";
          keyColor = "yellow";
        }
        {
          type = "kernel";
          key = "│ ├ Kernel";
          keyColor = "yellow";
        }
        {
          type = "packages";
          key = "│ ├󰏖 Packages";
          keyColor = "yellow";
        }
        {
          type = "shell";
          key = "│ ├ Shell";
          keyColor = "yellow";
        }
        {
          type = "command";
          key = "│ ├ OS Age";
          keyColor = "yellow";
          text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
        }
        {
          type = "uptime";
          key = "└ └ Uptime";
          keyColor = "yellow";
        }
        "break"
        {
          type = "de";
          key = " DE";
          keyColor = "blue";
        }
        {
          type = "lm";
          key = "│ ├ LM";
          keyColor = "blue";
        }
        {
          type = "wm";
          key = "│ ├ WM";
          keyColor = "blue";
        }
        {
          type = "gpu";
          key = "│ ├󰍛 GPU Driver";
          format = "{3}";
          keyColor = "blue";
        }
        {
          type = "wmtheme";
          key = "└ └󰉼 Theme";
          keyColor = "blue";
        }
        {
          type = "custom";
          format = "└────────────────────────────────────────────────────┘";
          outputColor = "red";
        }
        "break"
      ];
    };
  };

  home.file = {
    ".config/fastfetch/fetch.png".source = ./fetch.png;
  };
}
