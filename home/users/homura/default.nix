{ ... }:
{
  imports = [ ../shared.nix ];

  module = {
    # Temporary LUKS test set — restore the full profile after.
    fish.enable = true;
    foot.enable = true;
    fastfetch.enable = false;
    zellij.enable = false;

    vscode.enable = true;
    cursor.enable = true;
    rider.enable = false;

    firefox.enable = true;
    neovim.enable = false;
    git.enable = true;
    wl-clipboard.enable = true;
    telegram.enable = true;
    chafa.enable = false;
    nil.enable = false;
    nordic.enable = true;
    libqalculate.enable = false;
    audio-tools.enable = false;
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
