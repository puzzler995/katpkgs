{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  obs-studio,
  pkg-config,
  fftwFloat
}:

stdenv.mkDerivation rec {
  pname = "obs-captions-plugin";
  version = "0.30";

  src = fetchFromGitHub {
    owner = "ratwithacompiler";
    repo = "OBS-captions-plugin";
    rev = "v${version}";
    hash = "sha256-Bg1n1yV4JzNFEXFNayNa1exsSZhmRJ0RLHDjLWmqGZE=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  postFixup = ''
    mkdir -p $out/lib $out/share/obs/obs-plugins
    mv $out/${pname}/bin/64bit $out/lib/obs-plugins
    mv $out/${pname}/data $out/share/obs/obs-plugins/${pname}
    rm -rf $out/${pname}
  '';

  buildInputs = [
    obs-studio
    fftwFloat
  ];

  meta = {
    description = "Closed Captioning OBS plugin using Google Speech Recognition";
    homepage = "https://github.com/ratwithacompiler/OBS-captions-plugin";
    maintainers = [];
    license = lib.licenses.gpl2;
    platforms = ["x86_64-linux"];
  };
}