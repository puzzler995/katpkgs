{lib, appimageTools, fetchurl, nix-update-script, pkgs}: 
let 
  pname = "touch-portal";
  version = "4.4";
  src = fetchurl {
    url = "https://www.touch-portal.com/downloads/releases/linux/TouchPortal.AppImage";
    hash = "sha256-TDBvk9mSj7sGiHFpc1uUyMQB6WvknSSFtVtMcAz0WQw=";
  };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = pkgs: with pkgs; [temurin-jre-bin-25 python3Minimal];

  passthru.updateScript = nix-update-script {};

  extraInstallCommands = ''
    install -Dm444 ${appimageContents}/TouchPortal.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/TouchPortal.desktop \
      --replace-fail 'Exec=TouchPortal' "Exec=touch-portal"
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  meta = {
    description = "Mobile Remote Control";
    homepage = "https://www.touch-portal.com";
    license = lib.licenses.unfree;
    maintainers = [];
    platforms = [ "x86_64-linux"];
  };
}
