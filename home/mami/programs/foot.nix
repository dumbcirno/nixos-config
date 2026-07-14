{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
  foot
  ];

 programs.foot.enable = true;
 programs.foot.settings = {
   main = {
     font = "JetBrains Mono:size=13";
   };
   colors = {
     alpha = 0.7;
     foreground = "E9EEF5";
     background = "000000";

     regular0 = "0B0F14";
     regular1 = "FF3B30";
     regular2 = "2AABEE";
     regular3 = "FFCC00";
     regular4 = "34C759";
     regular5 = "AF52DE";
     regular6 = "34C759";
     regular7 = "E9EEF5";

     bright0 = "6B7280";
     bright1 = "FF453A";
     bright2 = "64D2FF";
     bright3 = "FFD60A";
     bright4 = "30D158";
     bright5 = "BF5AF2";
     bright6 = "66D4FF";
     bright7 = "F5F7FA";

     cursor = "2AABEE 000000";
   };
 };
}

