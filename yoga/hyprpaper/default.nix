{ ... }:
{
  imports = [ (import ./hyprpaper.nix) ]
    ++ [ (import ./settings.nix) ];
}
