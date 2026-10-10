{ ... }:
{
  programs.walker = {
    enable = true;
    runAsService = false;

    config.theme = "mami";

    themes.mami = {
  style = ''
    @define-color window_bg_color #1f1f28;
    @define-color accent_bg_color #54546d;
    @define-color theme_fg_color #e9eef5;
    @define-color error_bg_color #C34043;
    @define-color error_fg_color #DCD7BA;

    * {
      all: unset;
    }

    .box-wrapper {
      box-shadow:
        0 19px 38px rgba(0, 0, 0, 0.3),
        0 15px 12px rgba(0, 0, 0, 0.22);
      background: @window_bg_color;
      padding: 20px;
      border-radius: 20px;
      border: 1px solid darker(@accent_bg_color);
    }

    .preview-box,
    .elephant-hint,
    .placeholder,
    .list,
    .preview,
    .keybinds {
      color: @theme_fg_color;
    }

    .input {
      caret-color: @theme_fg_color;
      background: #ff000073;
      padding: 10px;
      color: @theme_fg_color;
      border: 2px solid #ffffff14;
      border-radius: 14px;
    }

    .input placeholder {
      opacity: 0.5;
    }

    .item-box {
      border-radius: 10px;
      padding: 10px;
    }

    child:selected .item-box,
    row:selected .item-box {
      background: #0D141DB3;
    }

    .item-subtext {
      font-size: 12px;
      opacity: 0.5;
    }

    .keybinds {
      padding-top: 10px;
      border-top: 1px solid lighter(@window_bg_color);
      font-size: 12px;
    }

    .error {
      padding: 10px;
      background: @error_bg_color;
      color: @error_fg_color;
    }
  '';
  };
  };

  programs.elephant.installService = false;
}
