_: self: super: {
  natron = super.natron.overrideAttrs (prev: rec {
    nativeBuildInputs = prev.nativeBuildInputs ++ [super.glog];
  });
}
