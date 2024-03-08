{ pkgs, ... }:
let
  pname = "pygad";
  version = "3.3.1";
in
pkgs.python3Packages.buildPythonPackage {
  inherit pname version;
  src = pkgs.fetchFromGitHub rec {
    owner = "ahmedfgad";
    repo = "GeneticAlgorithmPython";
    rev = "${version}";
    sha256 = "sha256-Tie1gTcoHItGlqKr+wemh1m6KTbW8cEB1iDgEl7Wap8=ha256-Tie1gTcoHItGlqKr+wemh1m6KTbW8cEB1iDgEl7Wap8=";
  };
  doCheck = false;
}
