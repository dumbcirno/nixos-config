{ linuxUnstablePkgs, pkgs, ... }:
{
  home.packages = [
    linuxUnstablePkgs.xwayland-satellite
  ] ++ (with pkgs; [
    firefox
    neovim
    wl-clipboard
    telegram-desktop
    git
    chafa
    nil
    nordic
    libqalculate

    pavucontrol
    pamixer

    nodejs
    python3
    gcc
    dotnet-sdk_8

    hysteria

    gajim
  ]);

  programs.nix-index.enable = true;
  nixpkgs.config.allowUnfree = true;
}

