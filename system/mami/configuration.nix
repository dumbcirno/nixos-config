{ config, lib, linuxUnstablePkgs, pkgs, ... }:

{
  imports = [
    ./users.nix
    ./pam-homes.nix
    ./disko-homes.nix
    # ./dev-services.nix  # docker/mongo/postgres/rabbitmq/bluetooth — off for LUKS test
  ];

  # Fill these on mami after creating/formatting the two home partitions.
  # See docs/luks-homes.md — use different LUKS passphrases per user.
  mami.madoka = {
    partUuid = "ffeb7a33-7d99-4996-8abb-5e0557bd0650";  # nvme0n1p3 120G
    luksUuid = "d307a027-1e13-454f-8106-dd07972b48c0";
  };
  mami.homura = {
    partUuid = "9119ad4e-c39b-43a0-968a-c0d320f2ce68";  # nvme0n1p4 37G
    luksUuid = "b23842c8-75a4-4a5b-93c2-34396ad14d57";
  };

  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      efiInstallAsRemovable = false;
    };
    efi.canTouchEfiVariables = true;
  };

  fileSystems = {
    "/boot".options = [ "fmask=0022" "dmask=0022" ];
    "/".options = [
      "noatime"
      "compress=zstd"
      "discard=async"
    ];
  };

  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = [ "/" ];
  };

  networking.hostName = "mami";
  time.timeZone = "Europe/Moscow";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  environment.systemPackages = with pkgs; [
    vim
    wget
    sudo
    pipewire
    flatpak
    wireguard-tools
    cryptsetup
    linuxUnstablePkgs.xwayland-satellite
    linuxUnstablePkgs.xwayland
    amnezia-vpn
  ];

  programs.amnezia-vpn.enable = true;

  services.flatpak.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  programs.fish.enable = true;

  programs.niri = {
    enable = true;
    package = linuxUnstablePkgs.niri;
  };

  programs.dconf.enable = true;

  xdg.portal = {
    enable = lib.mkForce true;
    extraPortals = lib.mkForce (with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ]);
    configPackages = lib.mkForce [ linuxUnstablePkgs.niri ];
    config.niri = {
      default = [
        "gnome"
        "gtk"
      ];
      "org.freedesktop.impl.portal.Access" = "gtk";
      "org.freedesktop.impl.portal.FileChooser" = "gtk";
      "org.freedesktop.impl.portal.Notification" = "gtk";
      "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
    };
  };

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Strip niri.cachix.org if it was added by a previous generation or user nix.conf.
  nix.settings.substituters = lib.mkOverride 1000 (
    lib.filter (s: s != "https://niri.cachix.org") config.nix.settings.substituters
  );
  nix.settings.trusted-public-keys = lib.mkOverride 1000 (
    lib.filter (k: !lib.hasInfix "niri.cachix.org") config.nix.settings.trusted-public-keys
  );

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    XDG_CURRENT_DESKTOP = "niri";
  };

  system.stateVersion = "25.11";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;
}
