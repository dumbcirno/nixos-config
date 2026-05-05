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
     #color = "2e3440 d8dee9";
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

#     foreground = "d8dee9";
#     background = "2e3440";
#
#     regular0 = "3b4252";
#     regular1 = "bf616a";
#     regular2 = "a3be8c";
#     regular3 = "ebcb8b";
#     regular4 = "81a1c1";
#     regular5 = "b48ead";
#     regular6 = "88c0d0";
#     regular7 = "e5e9f0";
#
#     bright0 = "4c566a";
#     bright1 = "bf616a";
#     bright2 = "a3be8c";
#     bright3 = "ebcb8b";
#     bright4 = "81a1c1";
#     bright5 = "b48ead";
#     bright6 = "8fbcbb";
#     bright7 = "eceff4";
#     dim0 = "373e4d";
#     dim1 = "94545d";
#     dim2 = "809575";
#     dim3 = "b29e75";
#     dim4 = "68809a";
#     dim5 = "8c738c";
#     dim6 = "6d96a5";
#     dim7 = "aeb3bb";
   };
 };
}

