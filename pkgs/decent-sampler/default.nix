{ lib
, stdenv
, fetchzip
, fetchurl
, makeDesktopItem
, copyDesktopItems
, buildFHSEnv
, alsa-lib
, freetype
, nghttp2
, libX11
,
}:

let
  pname = "decent-sampler";
  version = "1.12.5";

  decent-sampler = stdenv.mkDerivation {
    inherit pname version;

    src = fetchzip {
      # dropbox links: https://www.dropbox.com/sh/dwyry6xpy5uut07/AABBJ84bjTTSQWzXGG5TOQpfa\
      url = "https://archive.org/download/decent-sampler-linux-static-download-mirror/Decent_Sampler-${version}-Linux-Static-x86_64.tar.gz";
      hash = "sha256-jr2bl8nQhfWdpZZGQU6T6TDKSW6SZpweJ2GiQz7n9Ug=";
    };

    nativeBuildInputs = [ copyDesktopItems ];

    installPhase = ''
      runHook preInstall

      install -Dm755 DecentSampler $out/bin/decent-sampler
      install -Dm755 DecentSampler.so -t $out/lib/vst
      install -d "$out/lib/vst3" && cp -r "DecentSampler.vst3" $out/lib/vst3

      runHook postInstall
    '';
  };
in
buildFHSEnv {
  inherit (decent-sampler) pname version;

  targetPkgs = pkgs: [
    alsa-lib
    decent-sampler
    freetype
    nghttp2
    libX11
  ];

  runScript = "decent-sampler";

  extraInstallCommands = ''
    cp -r ${decent-sampler}/lib $out/lib
  '';
}
