{ pkgs, ... }:
{
home.pointerCursor = {
  gtk.enable = true;
  package = pkgs.nordic;
  name = "Nordic-cursors";
  size = 16;
};

gtk = {
  enable = true;
  gtk3.extraConfig = {
    gtk-application-prefer-dark-theme = true;
  };
  theme = {
    package = pkgs.nordic;
    name = "Nordic";
  };
  iconTheme = {
    package = pkgs.nordic;
    name = "Nordic-bluish"; 
  };

  font = {
    name = "Noto Sans";
    size = 13;
  };

  cursorTheme = {
  package = pkgs.nordic;
  name = "Nordic-cursors";
  size = 16;
  };
};
}

