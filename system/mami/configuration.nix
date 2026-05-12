{ pkgs, ... }:
{
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;


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
  home.stateVersion = "23.11";
};

home-manager.backupFileExtension = "hm-bak";

 environment.systemPackages = with pkgs; [
   vim 
   wget
   sudo
   pipewire
];

fonts.packages = with pkgs; [
   jetbrains-mono
   nerd-fonts.jetbrains-mono
  noto-fonts
  noto-fonts-cjk-sans
];

programs.fish.enable = true;
programs.hyprland.enable = true;
environment.sessionVariables.NIXOS_OZONE_WL = "1";

system.stateVersion = "23.11"; 

nixpkgs.config.allowUnfree = true;

}

