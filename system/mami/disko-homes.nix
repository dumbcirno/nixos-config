# Dual-boot safe: disko targets ONLY the empty partitions created for encrypted
# homes. It does NOT describe Windows, ESP, or the NixOS root.
#
# On mami (destructive — verify each PARTUUID is empty first):
#   1. Free space → create TWO new Linux partitions (gparted / parted).
#   2. lsblk -o NAME,SIZE,PARTUUID,FSTYPE,MOUNTPOINT
#   3. Set mami.madoka.partUuid and mami.homura.partUuid (see docs/luks-homes.md).
#   4. Format ONLY those partitions, e.g.:
#        sudo nix run github:nix-community/disko -- --mode format \
#          --flake /path/to/nixos-config#mami
#      Use a DIFFERENT LUKS passphrase per user; each must match that user's login password.
#   5. cryptsetup luksUUID /dev/disk/by-partuuid/<PARTUUID> for each
#      → set mami.madoka.luksUuid and mami.homura.luksUuid
#   6. nixos-rebuild switch
#
# Boot must NOT prompt for these LUKS volumes (initrdUnlock = false).
{ config, ... }:
let
  mkLuksDisk = name: partUuid: {
    # Treat the single partition as the disko "disk" so format never touches
    # the rest of the GPT (Windows / NixOS root / ESP).
    type = "disk";
    device = "/dev/disk/by-partuuid/${partUuid}";
    content = {
      type = "luks";
      inherit name;
      initrdUnlock = false;
      askPassword = true;
      settings = {
        allowDiscards = true;
      };
      content = {
        type = "filesystem";
        format = "ext4";
        # pam_mount / cryptHomeLuks owns the mount; no boot-time fileSystems entry.
        mountpoint = null;
      };
    };
  };
in
{
  disko.devices.disk = {
    madoka = mkLuksDisk "madoka" config.mami.madoka.partUuid;
    homura = mkLuksDisk "homura" config.mami.homura.partUuid;
  };
}
