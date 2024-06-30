{ pkgs }:
pkgs.mkShell {
  packages =
    with pkgs;
    let
      python-with-my-packages = python3.withPackages (ps: with ps; [
        numpy
        transformers
        torch
        pillow
        requests
        opencv4
      ]);
    in
    [
      python-with-my-packages
      fswebcam # fswebcam --dumpframe out.jpg -D 3 -S 13 # skip frames for iso adjustment
    ];
}


