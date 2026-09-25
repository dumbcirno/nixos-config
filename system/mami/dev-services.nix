{ pkgs, ... }:
{
  virtualisation.docker.enable = true;

  services.mongodb = {
    enable = true;
    package = pkgs.mongodb-ce;
    bind_ip = "127.0.0.1";
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;
  };

  services.rabbitmq.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;
}
