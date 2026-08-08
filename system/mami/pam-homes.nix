{ config, lib, ... }:
let
  mkLuksHomeOptions = user: {
    partUuid = lib.mkOption {
      type = lib.types.str;
      default = "REPLACE_AFTER_PARTITIONING";
      description = "GPT PARTUUID of the empty partition reserved for ${user} LUKS home.";
    };

    luksUuid = lib.mkOption {
      type = lib.types.str;
      # Filled on mami after: cryptsetup luksUUID /dev/disk/by-partuuid/<PARTUUID>
      default = "REPLACE_AFTER_LUKS_FORMAT";
      description = "UUID of the LUKS container used for /home/${user} (not the inner filesystem UUID).";
    };
  };

  madoka = config.mami.madoka;
  homura = config.mami.homura;
in
{
  options.mami.madoka = mkLuksHomeOptions "madoka";
  options.mami.homura = mkLuksHomeOptions "homura";

  config = {
    security.pam.mount.enable = true;

    # Unlock + mount at login (TTY). Login password must match that user's LUKS passphrase.
    # Not unlocked in initrd — see disko-homes.nix (initrdUnlock = false).
    users.users.madoka.cryptHomeLuks = "/dev/disk/by-uuid/${madoka.luksUuid}";
    users.users.homura.cryptHomeLuks = "/dev/disk/by-uuid/${homura.luksUuid}";
  };
}
