---
name: privilege-escalation
description: >-
  Elevate to root for nixos-rebuild switch and other privileged NixOS commands
  when the agent shell has no TTY. Use when running sudo, pkexec, nixos-rebuild
  switch, switch-to-configuration, or when sudo fails with "a terminal is
  required to read the password".
---

# Privilege escalation (NixOS rebuild)

Agent shells here cannot prompt for `sudo` (no TTY). Do not probe `sudo -n`,
askpass helpers, or credential paths — that gets blocked. Follow this sequence.

## 1. Build without root

```bash
nixos-rebuild build --flake .#mami
```

Needs `all` permissions (sandbox + network + store). Fix eval/build errors
before elevating. On success the last line is:

```
Done. The new configuration is /nix/store/<hash>-nixos-system-mami-<version>
```

## 2. Elevate with pkexec, not sudo

`sudo` fails immediately (`a terminal is required to read the password`).
`SUDO_ASKPASS` + `systemd-ask-password` times out; zenity/kdialog are often
missing. `pkexec` shows a polkit dialog on the desktop.

Do **not** run `pkexec nixos-rebuild --flake /etc/nixos/nixos-config#…`.
Nix (libgit2) refuses a user-owned flake as root:

```
repository path '/etc/nixos/nixos-config' is not owned by current user
```

`GIT_CONFIG_*` / `safe.directory` env vars do not fix this.

## 3. Activate the already-built system

```bash
SYSTEM=/nix/store/<hash>-nixos-system-mami-<version>
pkexec bash -c "nix-env -p /nix/var/nix/profiles/system --set '$SYSTEM' && '$SYSTEM'/bin/switch-to-configuration switch"
```

This is what `nixos-rebuild switch` does after a successful build. The user
approves the polkit prompt on the desktop.

## 4. Verify

- `readlink -f /run/current-system` matches `$SYSTEM`
- new units from the change are active
- `home-manager-<user>.service` is a oneshot: `inactive` after `status=0` is OK
