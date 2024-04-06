{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, numpy
, matplotlib
, cloudpickle
, torch
, tensorflow
, keras
}:

buildPythonPackage rec {
  pname = "pygad";
  version = "3.3.1";
  disabled = (pythonOlder "3.7");

  src = fetchFromGitHub {
    owner = "ahmedfgad";
    repo = "GeneticAlgorithmPython";
    rev = version;
    sha256 = "sha256-Tie1gTcoHItGlqKr+wemh1m6KTbW8cEB1iDgEl7Wap8=ha256-Tie1gTcoHItGlqKr+wemh1m6KTbW8cEB1iDgEl7Wap8=";
  };

  catchConflicts = false;

  buildInputs = [
    numpy
    matplotlib
    cloudpickle
    torch
    tensorflow
    keras
  ];

  meta = with lib; {
    description = "Library for building the genetic algorithm and optimizing machine learning algorithms";
    homepage = "https://github.com/ahmedfgad/GeneticAlgorithmPython";
    changelog = "https://github.com/ahmedfgad/GeneticAlgorithmPython/releases/tag/${version}";
    license = licenses.bsd3;
    maintainers = [ ];
  };
}
