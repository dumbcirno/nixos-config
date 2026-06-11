{ ... }:
{
  programs.walker = {
    enable = true;
    runAsService = false;

    config.theme = "mami";

    themes.mami = {
      style = ''
        * {
          color: #e9eef5;
        }

        #search {
          background-color: #00000073;
          border: 2px solid #ffffff14;
          border-radius: 14px;
        }

        #item:selected {
          background-color: #0D141DB3;
        }
      '';
    };
  };

  programs.elephant.installService = false;
}
