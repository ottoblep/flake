{ pkgs }:
pkgs.mkShell {
  packages =
    with pkgs;
    let
      python-with-my-packages =
        python311.withPackages (ps: with ps; [
          pandas
          numpy
          scipy
          seaborn
          plotly
          networkx
        ]);
    in
    [
      python-with-my-packages
    ];
}
