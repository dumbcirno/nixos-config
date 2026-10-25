{ lib, config, pkgs, ... }:
let
  cfg = config.module.x11-dev;
  # SFML (and most X11 CMake projects) need headers + .pc files, not just .so.
  libs = with pkgs; [
    xorg.libX11
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXi
    xorg.libXext
    xorg.xorgproto
    libudev-zero
    libGL
    freetype
    openal
    flac
    libvorbis
    libogg
    libwebp
  ];
  prefixes = lib.concatStringsSep ":" (lib.unique (map toString (libs ++ map lib.getDev libs)));
  includes = lib.makeSearchPathOutput "dev" "include" libs;
  libraries = lib.makeLibraryPath libs;
  pkgconfig = lib.makeSearchPathOutput "dev" "lib/pkgconfig" libs;
  cflags = lib.concatMapStringsSep " " (p: "-isystem ${lib.getDev p}/include") libs;
  ldflags = lib.concatMapStringsSep " " (p: "-L${lib.getLib p}/lib") libs;
  cmakeWithX11 = pkgs.symlinkJoin {
    name = "cmake-with-x11";
    paths = [ pkgs.cmake ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/cmake \
        --prefix CMAKE_PREFIX_PATH : ${lib.escapeShellArg prefixes} \
        --prefix CMAKE_INCLUDE_PATH : ${lib.escapeShellArg includes} \
        --prefix CMAKE_LIBRARY_PATH : ${lib.escapeShellArg libraries} \
        --prefix PKG_CONFIG_PATH : ${lib.escapeShellArg pkgconfig}
    '';
  };
in
{
  options.module.x11-dev.enable = lib.mkEnableOption "X11 GL udev headers for CMake and SFML";

  config = lib.mkIf cfg.enable {
    # Do not merge X11 libs into ~/.nix-profile: libX11.dev and xorgproto
    # both ship XKBgeom.h and break home-manager-path.
    # Wrap cmake so Cursor/GUI terminals see the paths without login env.
    home.packages = [
      pkgs.pkg-config
      (lib.hiPrio cmakeWithX11)
    ];

    home.sessionVariables = {
      CMAKE_PREFIX_PATH = prefixes;
      CMAKE_INCLUDE_PATH = includes;
      CMAKE_LIBRARY_PATH = libraries;
      PKG_CONFIG_PATH = pkgconfig;
      NIX_CFLAGS_COMPILE = cflags;
      NIX_LDFLAGS = ldflags;
    };
  };
}
