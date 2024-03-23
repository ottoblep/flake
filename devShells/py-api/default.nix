{ pkgs }:
pkgs.mkShell {
  packages =
    with pkgs;
    let
      sdwebuiapi = ps: ps.callPackage ../../pkgs/sdwebuiapi { };

      python-with-my-packages = python3.withPackages (ps: with ps; [
        (sdwebuiapi ps)
        ps.requests
        ps.pillow
      ]);
    in
    [
      python-with-my-packages
    ];
}