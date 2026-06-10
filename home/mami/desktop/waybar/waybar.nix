{ linuxUnstablePkgs, ... }:
{
  programs.waybar = {
    enable = true;
    package = linuxUnstablePkgs.waybar;
    systemd = {
      enable = true;
      target = "niri.service";
    };
  };

  # Start after niri is up; niri-flake notes waybar can hit systemd restart limits otherwise.
  systemd.user.services.waybar = {
    Unit.After = [ "niri.service" ];
    Service = {
      RestartSec = 2;
      StartLimitBurst = 10;
    };
  };

  xdg.configFile."waybar/scripts/weebquote" = {
    source = ./scripts/weebquote;
    executable = true;
  };
}
