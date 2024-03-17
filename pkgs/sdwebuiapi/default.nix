{ pkgs, ... }:
let
  pname = "sdwebuiapi";
  version = "0.9.9";
in
pkgs.python3Packages.buildPythonPackage {
  inherit pname version;
  src = pkgs.fetchFromGitHub rec {
    owner = "mix1009";
    repo = "${pname}";
    rev = "15109bbe020a2e2ee5d589a64389f66127837096";
    sha256 = "sha256-vhuBU+82iBkf340Irs70wB5cJ7J+7uON1UmJ0woGq7k=";
  };
  doCheck = false;
}