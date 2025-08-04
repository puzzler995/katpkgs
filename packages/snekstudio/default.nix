{stdenv, lib, fetchFromGitHub, godot, godot-export-templates-bin, go makeWrapper}: 
stdenv.mkDerivation rec {
  pname = "snekstudio";
  version = "0.1.4";

  src = fetchFromGitHub {
    owner = "ExpiredPopsicle";
    repo = "SnekStudio";
    rev = "v${version}";
    sha256 = "sha256-A5QKqCo9TTdzmK13WRSAfkrKeUqHc4yQCzy4ZZ9uX2M=";
  };

  nativeBuildInputs = [
    godot4
  ];

  buildPhase = ''
    runHook preBuild

    export HOME=$TMPDIR

    mkdir -p $HOME/.local/share/godot
    ln-s ${godot-export-templates-bin}/share/godot/templates $HOME/.local/share/godot

    mkdir -p $out/bin
    godot --disable-render-loop --no-header --headless --script Build/WriteBuildVars.gd
    source Build/build_vars.sh

    godot --headless --path . --import

    godot --headless --path . --script Build/DownloadPythonRequirements.gd

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
  ''

}