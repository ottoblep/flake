{ pkgs }:
pkgs.mkShell {
  packages =
    with pkgs;
    let
      python-with-my-packages = 
      let
        ahpy = ps: ps.callPackage ../../pkgs/ahpy { };
        pygad = ps: ps.callPackage ../../pkgs/pygad { };
      in
      python311.withPackages (ps: with ps; [
        (ahpy ps)
        (pygad ps)
      ] 
      # ++ (pygad ps).optional-dependencies.keras 
      # ++ (pygad ps).optional-dependencies.torch
      );
    in
    [
      python-with-my-packages
    ];
}
