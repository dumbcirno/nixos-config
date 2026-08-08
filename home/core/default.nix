{ ... }:
{
  imports = [ ./env.nix ];

  nixpkgs.config.allowUnfree = true;
}
