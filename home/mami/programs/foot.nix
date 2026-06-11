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
   cursor = {
     color = "2AABEE 000000";
   };
   colors = {
     alpha = 0.7;
     foreground = "E9EEF5";
     background = "000000";

     regular0 = "0B0F14";
     regular1 = "FF3B30";
     regular2 = "34C759";
     regular3 = "FFCC00";
     regular4 = "2AABEE";
     regular5 = "AF52DE";
     regular6 = "32D7FF";
     regular7 = "E9EEF5";

     bright0 = "6B7280";
     bright1 = "FF453A";
     bright2 = "30D158";
     bright3 = "FFD60A";
     bright4 = "64D2FF";
     bright5 = "BF5AF2";
     bright6 = "66D4FF";
     bright7 = "F5F7FA";

   };
 };
}

