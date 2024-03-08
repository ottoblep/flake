{ pkgs, ... }:
let
  pname = "AHPy";
  version = "2.0";
in
pkgs.python3Packages.buildPythonPackage {
  inherit pname version;
  src = pkgs.fetchFromGitHub rec {
    owner = "PhilipGriffith";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "sha256-bVQpk1zLGyKhkICU9dQSylWp3obvlM6Ziw4Rxzhay7g=";
  };
  doCheck = false;
}
