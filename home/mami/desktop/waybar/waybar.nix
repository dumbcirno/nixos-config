{ pkgs, ... }:
{
  home.packages = with pkgs; [
  waybar
  ];

  programs.waybar.enable = true;

  xdg.configFile."waybar/scripts/weebquote" = {
    source = ./scripts/weebquote;
    executable = true;
  };
}
