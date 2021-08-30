with import <nixpkgs> { };

stdenv.mkDerivation rec {

  libX11 = pkgs.xorg.libX11;
  libXinerama = pkgs.xorg.libXinerama;
  libXft = pkgs.xorg.libXft;
  zlib = pkgs.zlib;
  patches = null;

  name = "tkiat-dmenu";

  src = fetchgit {
    url = "https://gitlab.com/tkiat/forked-dmenu.git";
    rev = "ef6d9a42b6db6580a9436245023c728c9d234c48";
    sha256 = "1l18gc6cgfd88m7sr8ia01fghh3m71vxh0x81m7q5nk6mcbhqzb0";
  };

  buildInputs = [ libX11 libXinerama zlib libXft ];

  postPatch = ''
    sed -ri -e 's!\<(dmenu|dmenu_path|stest)\>!'"$out/bin"'/&!g' dmenu_run
    sed -ri -e 's!\<stest\>!'"$out/bin"'/&!g' dmenu_path
  '';

  preConfigure = ''
    sed -i "s@PREFIX = /usr/local@PREFIX = $out@g" config.mk
  '';

  makeFlags = [ "CC:=$(CC)" ];

  meta = with lib; {
    description = "A generic, highly customizable, and efficient menu for the X Window System";
    homepage = "https://tools.suckless.org/dmenu";
    license = licenses.mit;
    maintainers = [ "Theerawat Kiatdarakun" ];
    platforms = platforms.linux;
  };
}
