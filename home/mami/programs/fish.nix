{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fish
    fishPlugins.grc
    grc
    fishPlugins.colored-man-pages
    fishPlugins.z
    fishPlugins.tide
  ];

  programs.fastfetch.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting

      # Start a full niri session (systemd + waybar / walker) when launching from a TTY.
      function niri --wraps niri
        if not set -q WAYLAND_DISPLAY; and not set -q NIRI_SOCKET
          command niri-session $argv
        else
          command niri $argv
        end
      end
    '';
    plugins = [
      {name = "grc"; src = pkgs.fishPlugins.grc.src;}
      {name = "z"; src = pkgs.fishPlugins.z.src;}
      {name = "colored-man-pages"; src = pkgs.fishPlugins.colored-man-pages.src;}
      {
        name = "tide";
        src = pkgs.fetchFromGitHub {
          owner = "IlanCosman";
          repo = "tide";
          rev = "a34b0c2809f665e854d6813dd4b052c1b32a32b4";
          sha256 = "sha256-ZyEk/WoxdX5Fr2kXRERQS1U1QHH3oVSyBQvlwYnEYyc=";
        };
      }
    ];
  };
}

