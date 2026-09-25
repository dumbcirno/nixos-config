{ ... }:
{
  imports = [ ./env.nix ];

  nixpkgs.config.allowUnfree = true;

  # User nix.conf — so `nix flake` works even if system nix.conf is stale.
  nix.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
