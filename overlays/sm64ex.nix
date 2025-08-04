_: self: super: {
  sm64ex = (super.sm64ex.override {
    stdenv = super.gcc15Stdenv;
  }).overrideAttrs (prev: rec {
    name = "sm64ex";
    version = "git";
    src = super.fetchFromGitHub {
      owner = "N00byKing";
      repo = "sm64ex";
      rev = "0e88a60f94535ef9653e9c66c53d3178d131e5e0";
      hash = "sha256-8gEsQca4lwRX2dDNfD+QlwZIVwLWIqaR2n3N+jd7yLE=";
      fetchSubmodules = true;
    };
    buildInputs = prev.buildInputs ++ [super.openssl];
    nativeBuildInputs = prev.nativeBuildInputs ++ [super.cmake];
    postInstall = "install -Dm755 build/us_pc/libAPCpp.so $out/lib/libAPCpp.so";
    dontUseCmakeConfigure = true;
  });
}
