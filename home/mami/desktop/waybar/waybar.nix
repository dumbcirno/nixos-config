{ lib, linuxUnstablePkgs, pkgs, ... }:
let
  launchWaybar = import ./launch-waybar.nix {
    inherit lib pkgs;
    waybarPackage = linuxUnstablePkgs.waybar;
  };
in
{
  programs.waybar = {
    enable = true;
    package = linuxUnstablePkgs.waybar;
    systemd = {
      enable = true;
      target = "niri.service";
    };
  };

  systemd.user.services.waybar = {
    Unit.After = [ "niri-portal-env.service" "niri.service" ];
    Service = {
      ExecStart = lib.mkForce (lib.getExe launchWaybar);
      Environment = "GTK_USE_PORTAL=0 GDK_BACKEND=wayland XDG_CURRENT_DESKTOP=niri";
      Restart = "on-failure";
      RestartSec = 2;
      StartLimitBurst = 15;
    };
  };

  xdg.configFile."waybar/scripts/weebquote" = {
    source = ./scripts/weebquote;
    executable = true;
  };
}
