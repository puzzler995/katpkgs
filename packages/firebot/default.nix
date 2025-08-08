{stdenv, fetchzip, autoPatchelfHook, pkgs, makeWrapper, lib, makeDesktopItem, copyDesktopItems}: 

stdenv.mkDerivation rec {
  name = "firebot";
  version = "5.64.0";

  src = fetchzip {
    url = "https://github.com/crowbartools/Firebot/releases/download/v${version}/firebot-v${version}-linux-x64.tar.gz";
    sha256 = "sha256-eg0OYi+dfqR/kKmH2AG2SF8pnWsEb54avGkoFCoJauY=";
    stripRoot = false;
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
    copyDesktopItems
  ];

  desktopItems = [ (makeDesktopItem {
    name = name;
    desktopName = name;
    exec = name;
    comment = "A Powerful all-in-one bot for Twitch Streamers";
    type = "application";
    categories = [
      "network"
      "chat"
    ];
  })];

  installPhase = ''
    mkdir -p $out/opt/firebot $out/share/applications $out/bin
    cp -rf firebot-v${version}-linux-x64/* $out/opt/firebot
    chmod +x $out/opt/firebot/Firebot\ v5

    ln -s $out/opt/firebot/Firebot\ v5 $out/bin/firebot
  '';

  postFixup = ''
    makeWrapper $out/opt/firebot/Firebot\ v5 $out/bin/firebot \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath buildInputs}:$out/opt/firebot
  '';

  meta = with lib; {
    description = "A Powerful all-in-one bot for Twitch Streamers";
    homepage = "https://firebot.app/";
    license = licenses.gpl3;
    platforms = [ "x86_64-linux" ];
  };
}