{...}: self: super: {
  _2ship2harkinian = super._2ship2harkinian.overrideAttrs (prev: rec {
    version = "2.0.1";
    src = super.fetchFromGitHub {
      owner = "HarbourMasters";
      repo = "2ship2harkinian";
      rev = "2.0.1";
      hash = "sha256-JLRw6dzhdY4LqzvLNCgdQZOxhF1TLSH1//82Sk3HrdA=";
      fetchSubmodules = true;
    };
  });
}
