# Dual LUKS homes (madoka + homura)

Both users get a **separate** LUKS volume with a **different** passphrase.
Volumes unlock only at that user's login (TTY / pam_mount), not at boot.
Root `/` (btrfs), ESP, and Windows are **not** reformatted by this setup.

```text
/          btrfs   (system, nix) — unencrypted
/home/madoka       ← LUKS passphrase A (madoka login)
/home/homura       ← LUKS passphrase B (homura login)
```

Switching TTY does not share keys: unlocking madoka never opens homura's disk.
If both sessions stay logged in, both volumes stay open until logout (normal).

## Prerequisites on mami

- Free space for **two** empty Linux partitions (shrink Windows or NixOS via live USB / gparted).
- This repo checked out; NixOS already installed.
- After pulling, update the lock for `disko` once if needed:

  ```bash
  nix flake update disko
  ```

## Steps

1. Create **two** empty Linux partitions in free space.

2. Identify them:

   ```bash
   lsblk -o NAME,SIZE,PARTUUID,FSTYPE,MOUNTPOINT
   ```

3. Set PARTUUIDs in [`system/mami/configuration.nix`](../system/mami/configuration.nix):

   ```nix
   mami.madoka.partUuid = "<MADOKA-PARTUUID>";
   mami.homura.partUuid = "<HOMURA-PARTUUID>";
   ```

4. Format **only** those partitions (wrong PARTUUID destroys data — confirm twice):

   ```bash
   sudo nix run github:nix-community/disko -- --mode format --flake .#mami
   ```

   Disko will ask for a LUKS passphrase per volume. Use **different** passphrases.
   Each passphrase **must match** that user's login password (`cryptHomeLuks`).

5. Read LUKS UUIDs:

   ```bash
   sudo cryptsetup luksUUID /dev/disk/by-partuuid/<MADOKA-PARTUUID>
   sudo cryptsetup luksUUID /dev/disk/by-partuuid/<HOMURA-PARTUUID>
   ```

6. Set in configuration:

   ```nix
   mami.madoka.luksUuid = "<MADOKA-LUKS-UUID>";
   mami.homura.luksUuid = "<HOMURA-LUKS-UUID>";
   ```

7. Apply:

   ```bash
   sudo nixos-rebuild switch --flake .#mami
   ```

8. Use:

   - Daily: graphical TTY as `madoka` → unlocks madoka LUKS.
   - Secure: `Ctrl+Alt+F3` → login `homura` → unlocks homura LUKS → `niri` (fish wraps `niri-session` on TTY).

## Migrate existing home into madoka LUKS

If data still lives on the root btrfs under `/home/madoka` or `/home/dumbcirno`:

1. Backup first.
2. After madoka LUKS is formatted and `luksUuid` is set, unlock once (login as madoka, or `cryptsetup open` manually).
3. Copy data onto the unlocked volume:

   ```bash
   # Example if old data is still on root (adjust paths):
   sudo rsync -aHAX /home/madoka.backup/ /home/madoka/
   # or from dumbcirno:
   sudo rsync -aHAX /home/dumbcirno/ /home/madoka/
   sudo chown -R madoka:users /home/madoka
   ```

4. Verify login + files, then remove the leftover unencrypted copy on root btrfs.

### dumbcirno → madoka rename (if still needed)

```bash
sudo usermod -l madoka dumbcirno
sudo groupmod -n madoka dumbcirno
sudo usermod -d /home/madoka -m madoka
```

Prefer migrate-then-delete over leaving two UIDs pointing at the same tree.

## Safety

- Never run disko `destroy` against the whole NVMe GPT.
- `initrdUnlock = false` — boot must not ask for either home LUKS password.
- `homura` has no `wheel`.
- Different passphrases = key isolation between users.
