{ config, lib, pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
      user = "greeter";
    };
  };

  users.users.greeter = {
    isSystemUser = true;
    group = "greeter";
    extraGroups = [ "video" ];
  };
  users.groups.greeter = { };

  # Let niri-session inherit the full user PATH from home-manager.
  systemd.user.services.niri.enableDefaultPath = lib.mkDefault false;
}
