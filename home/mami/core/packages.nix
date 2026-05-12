{ pkgs, ... }:
{
  home.packages = with pkgs; [
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
    dotnet-runtime_8

    hysteria

    amnezia-vpn

    gajim
  ];

  programs.nix-index.enable = true;
  nixpkgs.config.allowUnfree = true;
}

