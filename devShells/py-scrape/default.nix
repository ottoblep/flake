{ pkgs }:
pkgs.mkShell {
  packages =
    with pkgs;
    let
      python-with-my-packages = python3.withPackages (ps: with ps; [
        ps.beautifulsoup4
      ]);
    in
    [
      python-with-my-packages
    ];
}

