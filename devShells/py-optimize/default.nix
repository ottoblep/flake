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
      ]);
    in
    [
      python-with-my-packages
    ];
}
