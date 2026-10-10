{ lib, config, pkgs, ... }:
let
  cfg = config.module.distrobox;
  dockerBinPath = lib.makeBinPath [ pkgs.docker_29 ];
  distroboxWithDocker = pkgs.runCommand "distrobox" {
    nativeBuildInputs = [ pkgs.makeWrapper ];
    meta = pkgs.distrobox.meta;
  } ''
    mkdir -p $out/bin
    for bin in ${pkgs.distrobox}/bin/*; do
      makeWrapper "$bin" "$out/bin/$(basename "$bin")" \
        --prefix PATH : ${dockerBinPath}
    done
    mkdir -p $out/share
    cp -a ${pkgs.distrobox}/share/. $out/share/
  '';
in
{
  options.module.distrobox.enable = lib.mkEnableOption "distrobox ubuntu container";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.docker_29 ];

    programs.distrobox = {
      enable = true;
      package = distroboxWithDocker;
      settings = {
        container_manager = "docker";
        container_additional_volumes = "/nix:/nix";
      };
      containers = {
        ubuntu = {
          image = "ubuntu:24.04";
          home = "/home/madoka/.local/share/distrobox/ubuntu";
          pull = true;
          replace = false;
          additional_packages = [
            "git"
            "python3 python3-pip python3-venv jupyter-notebook"
            "gcc g++"
            "qtcreator qt6-wayland"
            "golang-go"
            "openjdk-21-jdk"
            "wireshark"
            "nodejs"
          ];
          pre_init_hooks = [
            "apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl ca-certificates gnupg"
            "curl -fsSL https://deb.nodesource.com/setup_22.x | bash -"
            "echo 'wireshark-common wireshark-common/install-setuid boolean true' | debconf-set-selections"
          ];
          init_hooks = [
            "ln -sf /usr/bin/distrobox-host-exec /usr/local/bin/docker"
            "npm install -g pnpm"
            "GOBIN=/usr/local/bin GOPROXY=https://proxy.golang.org,direct go install github.com/pressly/goose/v3/cmd/goose@latest"
            "curl -fsSL https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.6.3.tgz | tar -xz -C /opt && ln -sf /opt/apache-jmeter-5.6.3/bin/jmeter /usr/local/bin/jmeter"
          ];
          additional_flags = "--cap-add=NET_RAW --cap-add=NET_ADMIN";
          exported_apps = "qtcreator";
          exported_bins = "jmeter goose";
        };
      };
    };
  };
}
