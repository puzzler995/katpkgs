{inputs, ...}: self: super: {
  vvvvvv = super.vvvvvv.overrideAttrs (prev: rec {
    dataZip = inputs.v6data;
    name = "vvvvvv";
    version = "AP0.5.1-2";
    src = super.fetchFromGitHub {
      owner = "N00byKing";
      repo = "VVVVVV";
      rev = "027daa5da8de0255129637464a29130aefa427c6";
      hash = "sha256-JLRw6dzhdY4LezvLNCgdQZOxhF1TLSH1//82Sk3HrdA=";
      fetchSubmodules = true;
    };
    buildInputs = prev.buildInputs ++ [super.openssl];
    postInstall = "install -Dm755 apcppout/libAPCpp.so $out/lib/libAPCpp.so";
  });
}
