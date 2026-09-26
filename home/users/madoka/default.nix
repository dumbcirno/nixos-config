{ ... }:
{
  imports = [ ../shared.nix ];

  module = {
    # Shared shell / desktop helpers
    fish.enable = true;
    foot.enable = true;
    fastfetch.enable = true;
    zellij.enable = true;

    # Daily editors / tooling
    vscode.enable = true;
    cursor.enable = true;
    rider.enable = false;

    # Packages (telegram stays off for madoka)
    firefox.enable = true;
    neovim.enable = true;
    git.enable = true;
    wl-clipboard.enable = true;
    telegram.enable = false;
    chafa.enable = true;
    nil.enable = true;
    nordic.enable = true;
    libqalculate.enable = true;
    audio-tools.enable = true;
    devtools.enable = true;
    hysteria.enable = true;
    gajim.enable = true;
    nix-index.enable = true;

    chrome.enable = true;
    gh.enable = true;
    anki.enable = true;
    zoom.enable = true;
    trilium.enable = true;
    thunderbird.enable = true;
    librewolf.enable = true;
    obs.enable = true;
    qbittorrent.enable = true;
    camera.enable = true;
    media-tools.enable = true;
    wireshark.enable = true;
    cloud-tools.enable = true;
    db-clients.enable = true;
    postman.enable = true;
    android-studio.enable = true;
  };
}
