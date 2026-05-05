{ pkgs, ... }:
{
  home.packages = with pkgs; [
    firefox
    neovim
    wl-clipboard # wayland clipboard tool
    telegram-desktop
    git
    chafa
    nil # lsp for nix
    nordic # gtk nord theme
    libqalculate # calculator

    # tools for audio management
    pavucontrol
    pamixer

    nodejs
    python3
    gcc
    dotnet-sdk_8
    dotnet-runtime_8
 
    # jetbrains.rider
    hysteria

    amnezia-vpn

    gajim
  ];

  programs.nix-index.enable = true;
  nixpkgs.config.allowUnfree = true;
}

