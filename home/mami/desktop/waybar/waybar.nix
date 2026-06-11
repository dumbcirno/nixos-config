{ linuxUnstablePkgs, ... }:
{
  programs.waybar = {
    enable = true;
    package = linuxUnstablePkgs.waybar;
    systemd.enable = false;
  };

  xdg.configFile."waybar/scripts/weebquote" = {
    source = ./scripts/weebquote;
    executable = true;
  };
}
