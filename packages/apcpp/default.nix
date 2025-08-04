{stdenv, lib, fetchFromGitHub, cmake, openssl, pkg-config, pkgs}:

stdenv.mkDerivation rec {
  pname = "APCpp";
  version =  "0-unstable-2025-07-23";

  src = fetchFromGitHub {
    owner = "N00byKing";
    repo = pname;
    rev = "e2f443377384398b0f51255d849a1cfc4b2d89c8";
    hash = "sha256-MabT0nxpgvynrY6tnALXYkYpYlDWM2JB5/XBwNb5RZk=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [cmake pkg-config];

  buildInputs = [openssl];

   preFixup =  ''
    ${pkgs.sd}/bin/sd -F "''${exec_prefix}//nix/store" "/nix/store" $out/lib/pkgconfig/zlib.pc
  '';

  meta = with lib; {
    homepage = "https://github.com/N00byKing/APCpp";
    license = licenses.lgpl2;
  };
}