with import <nixpkgs> { }; stdenv.mkDerivation
rec {
  xorgproto = pkgs.xorg.xorgproto;
  libX11 = pkgs.xorg.libX11;
  libXext = pkgs.xorg.libXext;
  libXrandr = pkgs.xorg.libXrandr;
  conf = null;

  name = "slock-tkiat";

  src = fetchgit {
    url = "https://gitlab.com/tkiat/forked-slock.git";
    rev = "33f92e433732247395b9fb0d9d7336416a0057eb";
    sha256 = "0s43rliyc761s5xxaxc7sfrqx58y069801l14cda0h6fcz94416p";
  };

  buildInputs = [ xorgproto libX11 libXext libXrandr ];

  installFlags = [ "DESTDIR=\${out}" "PREFIX=" ];

  postPatch = "sed -i '/chmod u+s/d' Makefile";

  meta = with lib; {
    homepage = "https://tools.suckless.org/slock";
    description = "Simple X display locker";
    longDescription = ''
      Simple X display locker. This is the simplest X screen locker.
    '';
    license = licenses.mit;
    maintainers = [ "Theerawat Kiatdarakun" ];
    platforms = platforms.linux;
  };
}
