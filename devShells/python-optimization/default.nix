{ pkgs }:
pkgs.mkShell {
  packages =
    with pkgs;
    let
      ahpy = ps: ps.callPackage ../../pkgs/ahpy { };
      pygad = ps: ps.callPackage ../../pkgs/pygad { };

      python-with-my-packages = python3.withPackages (ps: with ps; [
        (ahpy ps)
        (pygad ps)
        ps.numpy
        ps.scipy
        ps.cloudpickle
        ps.matplotlib
      ]);
    in
    [
      python-with-my-packages
    ];
  }