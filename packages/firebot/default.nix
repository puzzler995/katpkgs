{stdenv, fetchzip, autoPatchelfHook, pkgs, makeWrapper, lib, makeDesktopItem}: 

stdenv.mkDerivation rec {
  name = "firebot";
  version = "5.64.0";

  src = fetchzip {
    url = "https://github.com/crowbartools/Firebot/releases/download/v${version}/firebot-v${version}-linux-x64.tar.gz";
    sha256 = "sha256-pJ7/wFpokQPcpTNwzQdMVJKOGKdWnEzV/ZlNLgbiZDM=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = with pkgs; [
    alsa-lib-with-plugins
    at-spi2-atk
    cups
    dbus
    glamoroustoolkit
    glib
    gtk3
    libdrm
    libgbm
    libGL
    libxkbcommon
    nspr
    nss
    pango
    systemd
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXfixes
    xorg.libXrandr
    xorg.libXtst
    xorg.libxcb
    xorg_sys_opengl
  ];

  desktopItem = makeDesktopItem {
    name = "firebot";
    desktopName = "Firebot v5";
    comment = "A Powerful all-in-one bot for Twitch Streamers";
    genericName = "Firebot v5";
    exec = "firebot %U";
    icon = "firebotv5";
    type = "Application";
    categories = [
      "Utility"
      "Network"
      "Chat"
    ];
  };

  installPhase = ''
    mkdir -p $out/opt/firebot $out/share/applications $out/bin
    cp -rf ${src}/* $out/opt/firebot/
    cp -rf ${./icons} $out/share/icons
    chmod +x $out/opt/firebot/Firebot\ v5

    #ln -s $out/opt/firebot/Firebot\ v5 $out/bin/firebot
    ln -s ${desktopItem}/share/applications/* $out/share/applications
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