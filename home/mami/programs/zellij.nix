{ pkgs, ... }:
{

  home.packages = with pkgs; [
    zellij
  ];

  programs.zellij.enable = true;
  programs.zellij.enableFishIntegration = false;
  programs.zellij.settings = {
    theme = "nord";
    default_layout = "compact";
  };
}

