{ buildPythonPackage
, fetchFromGitHub
, numpy
, scipy
, cloudpickle
, matplotlib
}:

buildPythonPackage rec {
  pname = "AHPy";
  version = "2.0";

  src = fetchFromGitHub {
    inherit pname version;
    owner = "PhilipGriffith";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-bVQpk1zLGyKhkICU9dQSylWp3obvlM6Ziw4Rxzhay7g=";
  };

  buildInputs = [
    numpy
    scipy
    cloudpickle
    matplotlib
  ];

  doCheck = false;
}
