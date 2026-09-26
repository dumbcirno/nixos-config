{ ... }:
{
  imports = [ ../shared.nix ];

  module = {
    # Shared shell / desktop helpers
    fish.enable = true;
    foot.enable = true;
    fastfetch.enable = true;
    zellij.enable = false;

    # Editors off in the secure profile
    vscode.enable = false;
    cursor.enable = false;
    rider.enable = false;

    # Minimal packages + high-value apps
    firefox.enable = false;
    neovim.enable = false;
    git.enable = false;
    wl-clipboard.enable = true;
    telegram.enable = true;
    chafa.enable = false;
    nil.enable = false;
    nordic.enable = true;
    libqalculate.enable = false;
    audio-tools.enable = true;
    devtools.enable = false;
    hysteria.enable = false;
    gajim.enable = false;
    nix-index.enable = false;

    chrome.enable = false;
    gh.enable = false;
    anki.enable = false;
    zoom.enable = false;
    trilium.enable = false;
    thunderbird.enable = false;
    librewolf.enable = false;
    obs.enable = false;
    qbittorrent.enable = false;
    camera.enable = false;
    media-tools.enable = false;
    wireshark.enable = false;
    cloud-tools.enable = false;
    db-clients.enable = false;
    postman.enable = false;
    android-studio.enable = false;
  };
}
