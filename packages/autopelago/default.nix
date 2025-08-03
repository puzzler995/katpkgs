{lib, fetchFromGitHub, buildDotnetModule,dotnetCorePackages}: 

buildDotnetModule rec {
  pname = "autopelago";
  version = "0.10.4";

  src = fetchFromGitHub {
    owner = "airbreather";
    repo = "Autopelago";
    rev = "v${version}";
    sha256 = "sha256-qTHJ5nuB5NF+ju5gmxkP/s7uRjrNpkkyBzkhD/0n4D4=";
  };

  selfContainedBuild = true;
  projectFile = "src/Autopelago/Autopelago.csproj";
  dotnet-sdk = dotnetCorePackages.sdk_9_0;
  nugetDeps = ./deps.json;

  extraInstallCommands = ''
    substituteAll ${./Autopelago.desktop} $out/share/applications/Autopelago.desktop
  '';

  meta = with lib; {
    homepage = "https://github.com/airbreather/Autopelago";
    license = licenses.agpl3Only;
  };
}