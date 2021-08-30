with import <nixpkgs> { };

stdenv.mkDerivation rec {

  fontconfig = pkgs.fontconfig;
  freetype = pkgs.freetype;
  ncurses = pkgs.ncurses;
  pkg-config = pkgs.pkg-config;
  libX11 = pkgs.xorg.libX11;
  libXft = pkgs.xorg.libXft;
  patches = [ ];
  extraLibs = [ ];

  name = "tkiat-st";

  src = fetchgit {
    url = "https://gitlab.com/tkiat/forked-st.git";
    rev = "3b51b794840bf74d72dce918dfdf75880cf3f5ce";
    sha256 = "1ra4bcmzbqx7nvy90haskdllb11smf2i8f8qqhf57i356h5h84zy";
  };

  strictDeps = true;

  makeFlags = [
    "PKG_CONFIG=${stdenv.cc.targetPrefix}pkg-config"
  ];

  nativeBuildInputs = [
    pkg-config
    ncurses
    fontconfig
    freetype
  ];
  buildInputs = [
    libX11
    libXft
  ] ++ extraLibs;

  installPhase = ''
    runHook preInstall
    TERMINFO=$out/share/terminfo make install PREFIX=$out
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://st.suckless.org/";
    description = "Simple Terminal for X from Suckless.org Community";
    license = licenses.mit;
    maintainers = [ "Theerawat Kiatdarakun" ];
    platforms = platforms.linux;
  };
}
