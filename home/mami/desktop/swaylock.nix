{ pkgs, ... }:
let
  glass = {
    fg = "e9eef5";
    fgDim = "e9eef5b3";
    panel = "00000094";
    panelBorder = "ffffff1f";
    accent = "78d2ff";
  };
  lockpaper = "${../../../assets/lockpaper.jpg}";
in {
  programs.swaylock = {
    enable = true;
    settings = {
      image = lockpaper;
      scaling = "fill";
      font = "JetBrains Mono Nerd Font Mono";
      font-size = 25;
      indicator-radius = 14;
      indicator-thickness = 2;
      indicator-idle-visible = true;
      indicator-stroke = 0;
      inside-color = "00000000";
      inside-clear-color = "00000000";
      inside-caps-lock-color = "00000000";
      inside-ver-color = "00000000";
      inside-wrong-color = "00000000";
      ring-color = glass.panelBorder;
      ring-clear-color = glass.panelBorder;
      ring-caps-lock-color = glass.panelBorder;
      ring-ver-color = glass.accent;
      ring-wrong-color = "ff3b30";
      separator-color = "00000000";
      text-color = glass.fg;
      text-clear-color = glass.fg;
      text-caps-lock-color = glass.fg;
      text-ver-color = glass.fg;
      text-wrong-color = glass.fg;
      key-layout = "us";
      show-failed-attempts = true;
      show-keyboard-layout = false;
    };
  };

}
