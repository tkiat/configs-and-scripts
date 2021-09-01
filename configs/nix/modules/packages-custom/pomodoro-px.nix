with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "pomodoro-px";

  src = fetchgit {
    url = "https://github.com/tkiat/pomodoro-px.git";
    rev = "be87061df5bdc8d92dbf2d44ec75da3805f39680";
    sha256 = "0nkxnvm952w8p1mhfraksnw2qqbd6kkma7va9fjbc2vl0qmbwmml";
  };
  #   src = builtins.fetchTarball "https://github.com/tkiat/pomodoro-px/archive/main.tar.gz";

  buildInputs = [
    (pkgs.python39.withPackages (ps: [ ]))
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/pomodoro-px.py $out/bin/$name
    chmod +x $out/bin/$name
  '';
}
