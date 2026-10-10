{ lib, config, pkgs, ... }:
let
  cfg = config.module.fish;
in
{
  options.module.fish.enable = lib.mkEnableOption "fish shell";

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      fish
      fishPlugins.grc
      grc
      fishPlugins.colored-man-pages
      fishPlugins.z
      fishPlugins.tide
    ];

    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting

        # Globals so a container fish (distrobox shares $HOME) cannot wipe host colors.
        set -g fish_color_autosuggestion brblack
        set -g fish_color_cancel -r
        set -g fish_color_command normal
        set -g fish_color_comment red
        set -g fish_color_cwd green
        set -g fish_color_cwd_root red
        set -g fish_color_end green
        set -g fish_color_error brred
        set -g fish_color_escape brcyan
        set -g fish_color_history_current --bold
        set -g fish_color_host normal
        set -g fish_color_host_remote yellow
        set -g fish_color_normal normal
        set -g fish_color_operator brcyan
        set -g fish_color_param cyan
        set -g fish_color_quote yellow
        set -g fish_color_redirection cyan --bold
        set -g fish_color_search_match white --background=brblack --bold
        set -g fish_color_selection white --background=brblack --bold
        set -g fish_color_status red
        set -g fish_color_user brgreen
        set -g fish_color_valid_path --underline
        set -g fish_pager_color_completion normal
        set -g fish_pager_color_description yellow -i
        set -g fish_pager_color_prefix normal --bold --underline
        set -g fish_pager_color_progress brwhite --background=cyan --bold
        set -g fish_pager_color_selected_background -r

        bind \cl 'printf "\033[2J\033[3J\033[H"; commandline -f repaint'

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
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
        {
          name = "z";
          src = pkgs.fishPlugins.z.src;
        }
        {
          name = "colored-man-pages";
          src = pkgs.fishPlugins.colored-man-pages.src;
        }
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
  };
}
