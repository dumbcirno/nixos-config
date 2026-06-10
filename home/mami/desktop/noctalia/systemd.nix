{ lib, noctalia, pkgs, ... }:
let
  noctaliaPackage = noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  systemd.user.services.noctalia = {
    Unit = {
      Description = "Noctalia Wayland shell";
      Documentation = "https://docs.noctalia.dev/v5/";
      After = [
        "niri.service"
        "niri-portal-env.service"
      ];
      Requires = [ "niri-portal-env.service" ];
      PartOf = [ "niri.service" ];
      BindsTo = [ "niri.service" ];
    };

    Service = {
      Type = "exec";
      ExecStart = lib.getExe noctaliaPackage;
      Restart = "on-failure";
      Environment = [
        "XDG_CURRENT_DESKTOP=niri"
        "XDG_SESSION_TYPE=wayland"
        "GDK_BACKEND=wayland"
      ];
    };

    Install.WantedBy = lib.mkForce [ "niri.service" ];
  };
}
