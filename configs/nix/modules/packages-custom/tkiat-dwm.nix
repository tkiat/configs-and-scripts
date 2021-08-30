with import <nixpkgs> { };

stdenv.mkDerivation rec {

  libX11 = pkgs.xorg.libX11;
  libXinerama = pkgs.xorg.libXinerama;
  libXft = pkgs.xorg.libXft;

  name = "tkiat-dwm";

  src = fetchgit {
    url = "https://gitlab.com/tkiat/forked-dwm.git";
    rev = "60f8de613fb4759a3dfb4ff90f452a46e37ec9a6";
    sha256 = "0slxljix450ppvlw1jqshxlq4n8fbd1irwa2xa65n4738wijijr3";
  };

  buildInputs = [ libX11 libXinerama libXft ];

  prePatch = ''
    sed -i "s@/usr/local@$out@" config.mk
  '';

  makeFlags = [ "CC=${stdenv.cc.targetPrefix}cc" ];

  meta = with lib; {
    homepage = "https://dwm.suckless.org/";
    description = "An extremely fast, small, and dynamic window manager for X";
    longDescription = ''
      dwm is a dynamic window manager for X. It manages windows in tiled,
      monocle and floating layouts. All of the layouts can be applied
      dynamically, optimising the environment for the application in use and the
      task performed.
      Windows are grouped by tags. Each window can be tagged with one or
      multiple tags. Selecting certain tags displays all windows with these
      tags.
    '';
    license = licenses.mit;
    maintainers = [ "Theerawat Kiatdarakun" ];
    platforms = platforms.linux;
  };
}

