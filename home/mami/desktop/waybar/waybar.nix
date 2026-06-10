{ linuxUnstablePkgs, ... }:
{
  programs.waybar = {
    enable = true;
    package = linuxUnstablePkgs.waybar;
  };

  xdg.configFile."waybar/scripts/weebquote" = {
    source = ./scripts/weebquote;
    executable = true;
  };
}
