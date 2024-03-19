{ pkgs }:
pkgs.mkShell {
  packages = with pkgs; [
    clippy
    rustc
    cargo
    rustfmt
    rust-analyzer
  ];

  RUST_BACKTRACE = 1;
}
