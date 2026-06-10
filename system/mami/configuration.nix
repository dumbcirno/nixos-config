{ linuxUnstablePkgs, pkgs, ... }:
{
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
   xwayland-satellite
 ];

fonts.packages = with pkgs; [
   jetbrains-mono
   nerd-fonts.jetbrains-mono
  noto-fonts
  noto-fonts-cjk-sans
];

programs.fish.enable = true;

# niri.cachix.org is unreachable from Russia; use nixpkgs binaries instead.
niri-flake.cache.enable = false;

programs.niri = {
  enable = true;
  # Use nixpkgs-unstable's pre-built niri (26.04 with blur) instead of
  # niri-flake's niri-unstable, which fails to install on NixOS 25.05.
  package = linuxUnstablePkgs.niri;
};
environment.sessionVariables = {
  NIXOS_OZONE_WL = "1";
  MOZ_ENABLE_WAYLAND = "1";
  GDK_BACKEND = "wayland,x11";
  QT_QPA_PLATFORM = "wayland;xcb";
  ELECTRON_OZONE_PLATFORM_HINT = "auto";
};

system.stateVersion = "25.05"; 

nixpkgs.config.allowUnfree = true;

}

