{ lib, fetchFromGitHub, python3Packages, python3, stdenv }: 

let 
  pythonEnv = python3.withPackages (ps: with ps; [requests]);
in
python3Packages.buildPythonPackage rec {
  pname = "nightbot-now-playing";
  version = "git-2025-07-19";

  buildInputs = [
    (python3.withPackages (pythonPackages: with pythonPackages; [
      requests
    ]))
    python3Packages.requests
  ];

  dependencies = [
    python3Packages.requests
  ];

  src = fetchFromGitHub {
    owner = "pixelchai";
    repo = "NightBotNowPlaying";
    rev = "1216b9ce2d66c2d9a6852cc090284d4cb909a37c";
    sha256 = "sha256-Dd85735Po8N+HfQSOU9xE+9L3CSV/26Af+FJ2cNbtvg=";
  };

  installPhase = ''
    mkdir -p $out/lib/nightbot-now-playing
    cp -r * $out/lib/nightbot-now-playing

    mkdir -p $out/bin
    cp ${./run.sh} $out/bin/nightbot-now-playing

    substituteInPlace $out/bin/nightbot-now-playing \
      --subst-var-by SCRIPT_DIR $out/lib/nightbot-now-playing \
      --subst-var-by PYTHON ${pythonEnv.interpreter}

    chmod +x $out/bin/nightbot-now-playing
  '';

  format = "other";

  meta = {
    description = "Tool to output the currently playing Nightbot song to a text file";
    homepage = "https://github.com/pixelchai/NightBotNowPlaying";
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [ ];
  };
}