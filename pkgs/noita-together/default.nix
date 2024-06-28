{ appimageTools, fetchurl }:
appimageTools.wrapType2 {
  pname = "noita-together";
  version = "0.10.8";

  src = fetchurl {
    url = "https://github.com/Noita-Together/noita-together/releases/download/v0.10.8/Noita-Together-Setup-0.10.8.AppImage";
    hash = "sha256-P0d96xIcncb2ifWz47khGfsHA3ZWXPKJ+vjhGZjYOgE=";
  };

  extraPkgs = pkgs: [ pkgs.libsecret ];
  # TODO: Currently requires extra argument --in-process-gpu to run
}
