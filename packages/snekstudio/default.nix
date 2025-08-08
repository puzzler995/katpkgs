{stdenv, lib, fetchFromGitHub, godot, godot-export-templates-bin, makeWrapper}: 
stdenv.mkDerivation rec {
  pname = "snekstudio";
  version = "0.1.4";

  src = fetchFromGitHub {
    owner = "ExpiredPopsicle";
    repo = "SnekStudio";
    rev = "v${version}";
    sha256 = "sha256-eQ4cWd8mddeSEoi/p1ee0cpmlVbgaHnBbuEGsC2YQKw=";
  };

  nativeBuildInputs = [
    godot
  ];

  buildPhase = ''
    runHook preBuild

    export HOME=$TMPDIR

    mkdir -p $HOME/.local/share/godot
    ln -s ${godot-export-templates-bin}/share/godot/templates $HOME/.local/share/godot

    mkdir -p $out/bin
    echo "One"
    godot --disable-render-loop --no-header --headless --script Build/WriteBuildVars.gd
    echo "Two"
    source Build/build_vars.sh

    echo "Three"
    godot --headless --path . --import

    echo "Four"
    godot --headless --path . --script Build/DownloadPythonRequirements.gd

    echo "Five"
    godot --headless --path . --export-release "Linux-x86_64 Build/Builds/SnekStudio_Linux-x86_64/snekstudio

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -D -m 755 -t $out/libexec ./Build/Builds/SnekStudio_Linux-x86_64/snekstudio
    install -D -m 644 -t $out/libexec ./Build/Builds/SnekStudio_Linux-x86_64/snekstudio.pck
    install -d -m 755 $out/bin

    ln -s $out/libexec/snekstudio $out/bin/snekstudio

    runHook postInstall
  '';

}