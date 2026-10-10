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
    padding=12
    border-size=1
    border-radius=14
    outer-margin=20
    max-icon-size=32

    background-color=#1f1f28
    text-color=#e9eef5
    border-color=#3d3d50
    progress-color=over #C34043

    [urgency=low]
    text-color=#e9eef59e

    [urgency=critical]
    background-color=#C34043
    text-color=#DCD7BA
    border-color=#C34043
  '';
}
