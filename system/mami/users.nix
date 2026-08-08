{ pkgs, ... }:
{
  # Login password must equal that user's LUKS passphrase (cryptHomeLuks / pam_mount).
  users.users.madoka = {
    name = "madoka";
    home = "/home/madoka";
    isNormalUser = true;
    createHome = true;
    extraGroups = [
      "wheel"
      "video"
    ];
    shell = pkgs.fish;
  };

  # Secure profile: no wheel. Home is LUKS + pam_mount (see pam-homes.nix).
  users.users.homura = {
    name = "homura";
    home = "/home/homura";
    isNormalUser = true;
    createHome = true;
    extraGroups = [ "video" ];
    shell = pkgs.fish;
  };

  home-manager.users.madoka = {
    home.username = "madoka";
    home.homeDirectory = "/home/madoka";
    home.stateVersion = "25.05";
  };

  home-manager.users.homura = {
    home.username = "homura";
    home.homeDirectory = "/home/homura";
    home.stateVersion = "25.05";
  };

  home-manager.backupFileExtension = "hm-bak";
}
