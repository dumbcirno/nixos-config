{ pkgs, ... }:
let
  exportPortalEnv = import ./portal-env-script.nix pkgs;
in
{
  systemd.user.services.niri-portal-env = {
    Unit = {
      Description = "Export niri Wayland environment for xdg-desktop-portal";
      After = [ "niri.service" ];
      PartOf = [ "niri.service" ];
      Before = [
        "xdg-desktop-autostart.target"
        "waybar.service"
      ];
    };
    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = exportPortalEnv;
    };
    Install.WantedBy = [ "niri.service" ];
  };
}
