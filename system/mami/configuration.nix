{ config, lib, linuxUnstablePkgs, pkgs, ... }:
{
  imports = [ ./greetd.nix ];

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

security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
};

users.users.dumbcirno = {
  name = "dumbcirno";
  home = "/home/dumbcirno";
  isNormalUser = true;
  extraGroups = [ "wheel" "video" ]; 
  shell = pkgs.fish;
};

home-manager.users.dumbcirno = {
  home.username = "dumbcirno";
  home.homeDirectory = "/home/dumbcirno";
  home.stateVersion = "25.05";
};

home-manager.backupFileExtension = "hm-bak";

 environment.systemPackages = with pkgs; [
   vim
   wget
   sudo
   pipewire
   linuxUnstablePkgs.xwayland-satellite
   linuxUnstablePkgs.xwayland
 ];

fonts.packages = with pkgs; [
   jetbrains-mono
   nerd-fonts.jetbrains-mono
  noto-fonts
  noto-fonts-cjk-sans
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

# Strip niri.cachix.org if it was added by a previous generation or user nix.conf.
nix.settings.substituters = lib.mkOverride 1000 (
  lib.filter (s: s != "https://niri.cachix.org") config.nix.settings.substituters
);
nix.settings.trusted-public-keys = lib.mkOverride 1000 (
  lib.filter (k: !lib.hasInfix "niri.cachix.org" k) config.nix.settings.trusted-public-keys
);
nix.settings.extra-substituters = lib.mkAfter [ "https://noctalia.cachix.org" ];
nix.settings.extra-trusted-public-keys = lib.mkAfter [
  "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
];
environment.sessionVariables = {
  NIXOS_OZONE_WL = "1";
  MOZ_ENABLE_WAYLAND = "1";
  QT_QPA_PLATFORM = "wayland;xcb";
  ELECTRON_OZONE_PLATFORM_HINT = "auto";
  XDG_CURRENT_DESKTOP = "niri";
};

system.stateVersion = "25.05"; 

nixpkgs.config.allowUnfree = true;

}

