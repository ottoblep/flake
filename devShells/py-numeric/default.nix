{ pkgs }:
pkgs.mkShell {
  packages =
    with pkgs;
    let
      python-with-my-packages =
        python312.withPackages (ps: with ps; [
          pandas
          numpy
          scipy
          seaborn
          plotly
          networkx
          sphinx
        ]);
    in
    [
      python-with-my-packages
    ];
}
