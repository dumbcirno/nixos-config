{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mako
  ];

  xdg.configFile."mako/config".text = ''
    default-timeout=5000

    font=monospace 11

    anchor=top-right
    width=400
    height=100
    padding=8
    border-size=1
    border-radius=3
    outer-margin=20
    max-icon-size=32
  '';
}
